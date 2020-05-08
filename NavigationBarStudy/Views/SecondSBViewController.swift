//
//  SecondSBViewController.swift
//  NavigationBarStudy
//
//  Created by hanulyun-tera on 2020/05/07.
//  Copyright © 2020 hanulyun. All rights reserved.
//

import UIKit

class SecondSBViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    static let identifier: String = "SecondSBViewController"
    static let segIdentifier: String = "SecondSegue"

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "SecondView-SB"

        view.backgroundColor = .systemGray3
        
        tableView.backgroundColor = .systemGray3
        tableView.separatorStyle = .singleLine
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SecondSBViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.backgroundColor = .systemGray3
        cell.textLabel?.text = "indexPath = \(indexPath)"
        return cell
    }
}

extension SecondSBViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
