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

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .singleLine
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureCustomNavi(_ navi: CustomNavi) {
        self.title = navi.rawValue
        self.navigationController?.navigationBar.tintColor = .systemIndigo
        switch navi {
        case .color:
            self.navigationController?.navigationBar.barTintColor = .systemYellow
        case .clear: // view의 backgroundColor로 보임
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage() // shadow clear
        case .colorShadow:
            self.navigationController?.navigationBar.shadowImage = colorToImage(.systemIndigo)
        case .blurShadow:
            self.navigationController?.navigationBar.layer.masksToBounds = false
            self.navigationController?.navigationBar.layer.shadowColor = UIColor.systemIndigo.cgColor
            self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
            self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.navigationController?.navigationBar.layer.shadowRadius = 2
        case .titleFont:
            self.navigationItem.titleView = attributeTitleView()
            let backButton: UIBarButtonItem = UIBarButtonItem()
            backButton.title = "Prev"
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        case .barButton:
            let leftBarButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(goBack))
            self.navigationItem.leftBarButtonItem = leftBarButton
            let rightBarButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(goBack))
            self.navigationItem.rightBarButtonItem = rightBarButton
            self.enableSwipeSetting()
        case .scrollHide:
            self.navigationController?.hidesBarsOnTap = true
            self.enableSwipeSetting()
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
        self.navigationController?.popViewController(animated: true)
    }
    
    private func enableSwipeSetting() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}

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
        cell.selectionStyle = .none
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
