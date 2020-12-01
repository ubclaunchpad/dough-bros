//
//  HomeViewController.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-09.
//

import UIKit

class SampleViewController: UIViewController {
    
    private var homeView: SampleView {
        return view as! SampleView
    }
    
    // MARK: - View Life Cycle -
    override func loadView() {
        super.loadView()
        
        view = SampleView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0xDEE8F4)
        homeView.openLoginButton.addTarget(self, action: #selector(openLoginVC), for: .touchUpInside)
    }
    
    
    @objc private func openLoginVC() {
//        let loginVC = LoginViewController()
//
//        present(loginVC, animated: true)
        
        let welcomeVC = WelcomeViewController()

        let nav = UINavigationController(rootViewController: welcomeVC)
        nav.navigationBar.isHidden = true
        present(nav, animated: true)
    }
    
}
