//
//  SecondViewController.swift
//  NavigationBarStudy
//
//  Created by hanulyun-tera on 2020/05/07.
//  Copyright © 2020 hanulyun. All rights reserved.
//

import UIKit

class SecondCodeViewController: UIViewController {
    
    private let tableView: UITableView = UITableView()
        
    private let navi: CustomNavi
    
    init(_ navi: CustomNavi) {
        self.navi = navi
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = .white
        
        configureCustomNavi(navi)
        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        let guide: UILayoutGuide = view.safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            ])
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
    
    private func configureCustomNavi(_ navi: CustomNavi) {
        self.title = navi.rawValue
        self.navigationController?.navigationBar.tintColor = .systemIndigo
        switch navi {
        case .color:
            navigationController?.navigationBar.barTintColor = .lightGray
        case .clear: // view의 backgroundColor로 보임
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage() // shadow clear
        case .colorShadow:
            navigationController?.navigationBar.shadowImage = colorToImage(.systemIndigo)
        case .blurShadow:
            navigationController?.navigationBar.layer.masksToBounds = false
            navigationController?.navigationBar.layer.shadowColor = UIColor.systemIndigo.cgColor
            navigationController?.navigationBar.layer.shadowOpacity = 0.8
            navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
            navigationController?.navigationBar.layer.shadowRadius = 2
        case .titleFont:
            navigationItem.titleView = attributeTitleView()
            let backButton: UIBarButtonItem = UIBarButtonItem()
            backButton.title = "Prev"
            navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        case .barButton:
            let leftBarButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(goBack))
            navigationItem.leftBarButtonItem = leftBarButton
            let rightBarButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(goBack))
            navigationItem.rightBarButtonItem = rightBarButton
            
            enableSwipeSetting()
        case .scrollHide:
            navigationController?.hidesBarsOnTap = true
        }
    }
    
    private func colorToImage(_ color: UIColor) -> UIImage {
        let size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        let image: UIImage = UIGraphicsImageRenderer(size: size).image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
        return image
    }
    
    private func attributeTitleView() -> UIView {
        let label: UILabel = UILabel()
        let lightText: NSMutableAttributedString = NSMutableAttributedString(string: "Title", attributes: [
            .foregroundColor: UIColor.systemIndigo,
            .font: UIFont.systemFont(ofSize: 18, weight: .light)
        ])
        let boldText: NSMutableAttributedString = NSMutableAttributedString(string: "Font", attributes: [
            .foregroundColor: UIColor.systemBlue,
            .font: UIFont.systemFont(ofSize: 20, weight: .medium)
        ])
        let naviTitle: NSMutableAttributedString = lightText
        naviTitle.append(boldText)
        
        label.attributedText = naviTitle
        return label
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func enableSwipeSetting() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

extension SecondCodeViewController: UIGestureRecognizerDelegate { }

extension SecondCodeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.textLabel?.text = "indexPath = \(indexPath)"
        return cell
    }
}

extension SecondCodeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if navi == .scrollHide {
            let pan: UIPanGestureRecognizer = scrollView.panGestureRecognizer
            let velocity: CGFloat = pan.velocity(in: scrollView).y
            if velocity < -5 {
                UIView.animate(withDuration: 0.3) {
                    self.navigationController?.setNavigationBarHidden(true, animated: true)
                }
            } else if velocity > 5 {
                UIView.animate(withDuration: 0.3) {
                    self.navigationController?.setNavigationBarHidden(false, animated: true)
                }
            }
        }
    }
}
