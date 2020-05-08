//
//  ViewController.swift
//  NavigationBarStudy
//
//  Created by hanulyun-tera on 2020/05/07.
//  Copyright © 2020 hanulyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var codePushButton: UIButton!
    @IBOutlet weak var seguePushButton: UIButton!
    @IBOutlet weak var sbPushButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        view.backgroundColor = .systemGray3
        
        codePushButton.addTarget(self, action: #selector(codePushButtonTap), for: .touchUpInside)
        seguePushButton.addTarget(self, action: #selector(seguePushButtonTap), for: .touchUpInside)
        sbPushButton.addTarget(self, action: #selector(sbPushButtonTap), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // NavigationBar Over Push
        self.navigationController?.navigationBar.barTintColor = .systemGray3
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        title = "Main"
    }

    @objc func codePushButtonTap() {
        let vc: SecondCodeViewController = SecondCodeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func seguePushButtonTap() {
        performSegue(withIdentifier: SecondSegueViewController.identifier, sender: nil)
    }
    
    @objc func sbPushButtonTap() {
        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc: SecondSBViewController = sb.instantiateViewController(identifier: SecondSBViewController.identifier)
            as? SecondSBViewController else { print("Nil SB"); return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIView {
    func convertImage() -> UIImage {
        let renderer: UIGraphicsImageRenderer = UIGraphicsImageRenderer(bounds: bounds)
        let renderedImage: UIImage = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        return renderedImage
    }
}
