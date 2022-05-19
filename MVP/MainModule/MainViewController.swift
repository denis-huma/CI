//
//  ViewController.swift
//  MVP
//
//  Created by Denis Yaremenko on 29.06.2020.
//  Copyright © 2020 Denis Yaremenko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableViiew: UITableView!
    
    var presenter: MainViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViiew.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension MainViewController: MainViewProtocol {
    func success() {
        tableViiew.reloadData()
    }
    
    func failure(error: Error) {
        print("Error Failure!")
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let comment = presenter.comments?[indexPath.row]
        cell.textLabel?.text = comment?.body
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = presenter.comments?[indexPath.row]
        presenter.tapOnTheComment(comment: comment)
//        let detailVC = ModelBuilder.createDetailModule(comment: comment)
//        navigationController?.pushViewController(detailVC, animated: true)
    }
}

