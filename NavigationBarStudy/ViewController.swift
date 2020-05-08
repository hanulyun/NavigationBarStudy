//
//  ViewController.swift
//  NavigationBarStudy
//
//  Created by hanulyun-tera on 2020/05/07.
//  Copyright © 2020 hanulyun. All rights reserved.
//

import UIKit

public enum CustomNavi: String, CaseIterable {
    case color = "Color"
    case clear = "Clear"
    case colorShadow = "ColorShadow"
    case blurShadow = "BlurShadow"
}

class ViewController: UIViewController {
    
    private let tableView: UITableView = UITableView()
    
    private var naviTypes: [CustomNavi] = CustomNavi.allCases.map({$0})
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = .white
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Custom Navigation"
        restoreNavigationBar()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        let guide: UILayoutGuide = view.safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func restoreNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = nil
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.layer.shadowColor = nil
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.navigationController?.navigationBar.layer.shadowOpacity = 0
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }
    
    @objc func seguePushButtonTap() {
        performSegue(withIdentifier: SecondSBViewController.segIdentifier, sender: nil)
    }
    
    @objc func sbPushButtonTap() {
        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc: SecondSBViewController = sb.instantiateViewController(identifier: SecondSBViewController.identifier)
            as? SecondSBViewController else { print("Nil SB"); return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return naviTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        let type: CustomNavi = naviTypes[indexPath.row]
        cell.textLabel?.text = type.rawValue
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type: CustomNavi = naviTypes[indexPath.row]
        let vc: SecondCodeViewController = SecondCodeViewController(type)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
