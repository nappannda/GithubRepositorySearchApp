//
//  ViewController.swift
//  GithubRepositorySearchApp
//
//  Created by 上原和輝 on 2017/06/01.
//  Copyright © 2017年 nappannda. All rights reserved.
//

import UIKit
import APIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
  
    @IBOutlet weak var sortPickerView: UIPickerView!
    @IBOutlet weak var orderPickerView: UIPickerView!
    @IBOutlet weak var repositoriesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let sortList = ["", "stars", "forks", "updated"]
    let orderList = ["desc", "asc"]
    let disposeBag = DisposeBag()
    var repositories = GithubRepositories()
    var searchText = ""
    var sortText = ""
    var orderText = "desc"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        sortPickerView.delegate = self
        sortPickerView.dataSource = self
        sortPickerView.tag = 1
        orderPickerView.delegate = self
        orderPickerView.dataSource = self
        orderPickerView.tag = 2
        
        
        searchBar.rx.text.orEmpty
            .throttle(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] q in
                    self.searchText = q
                    self.searchRepository()
                },
                onError: { err in
                },
                onCompleted: {
                }
            )
            .addDisposableTo(disposeBag)
        
        
    }
    
    func searchRepository() {
        let request = FetchRepositoriesRequest.init(query: self.searchText, sort: sortText, order: orderText)
        Session.rx_response(request: request)
            .subscribe(
                onNext: { GithubRepositories in
                    self.repositories = GithubRepositories
                },
                onError:{ err in
                },
                onCompleted: {
                    self.repositoriesTableView.reloadData()
                }
            )
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath as IndexPath) as! GithubRepositoryTableViewCell
        cell.setCell(repository: repositories.repositories[indexPath.row])
        
        return cell
    }
    
    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return sortList.count
        } else {
            return orderList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)-> String? {
        if pickerView.tag == 1 {
            return sortList[row]
        } else {
            return orderList[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            sortText = sortList[row]
        } else {
            orderText = orderList[row]
        }
        searchRepository()
    }

    
}

