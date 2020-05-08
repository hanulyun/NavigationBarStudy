//
//  SecondSegueViewController.swift
//  NavigationBarStudy
//
//  Created by hanulyun-tera on 2020/05/07.
//  Copyright © 2020 hanulyun. All rights reserved.
//

import UIKit

class SecondSegueViewController: UIViewController {
    static let identifier: String = "SecondSegueViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "SecondView-Segue"
        
        view.backgroundColor = .systemGray3
    }
}
