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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    let disposeBag = DisposeBag()
    var repositories = GithubRepositories()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        
        let request = FetchRepositoriesRequest.init(query: "tetris+language:assembly", sort: "stars", order: "desc")
        Session.rx_response(request: request)
            .subscribe(
                onNext: { GithubRepositories in
                    self.repositories = GithubRepositories
                    self.repositoriesTableView.reloadData()
                },
                onError:{ err in
                    print("err",err)
                },
                onCompleted: {
                
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

