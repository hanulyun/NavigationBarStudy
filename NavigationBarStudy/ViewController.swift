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
    case titleFont = "TitleFont"
    case barButton = "BarButton"
    case scrollHide = "ScrollHide"
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
        navigationController?.navigationBar.barTintColor = nil
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.layer.shadowColor = nil
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        navigationController?.navigationBar.layer.shadowOpacity = 0
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationItem.titleView = nil
        navigationController?.hidesBarsOnTap = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // Use Storyboard Segue
    @objc func seguePushButtonTap() {
        performSegue(withIdentifier: SecondSBViewController.segIdentifier, sender: nil)
    }
    
    // Use Storyboard
    @objc func sbPushButtonTap() {
        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc: SecondSBViewController = sb.instantiateViewController(identifier: SecondSBViewController.identifier)
            as? SecondSBViewController else { print("Nil SB"); return }
        navigationController?.pushViewController(vc, animated: true)
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
