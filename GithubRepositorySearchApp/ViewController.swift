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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var repositoriesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchText = ""
    
    let disposeBag = DisposeBag()
    var repositories = GithubRepositories()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        
        
        searchBar.rx.text
            .subscribe(onNext: { [unowned self] q in
                    self.searchText = q!
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
        let request = FetchRepositoriesRequest.init(query: self.searchText, sort: "", order: "")
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

}

