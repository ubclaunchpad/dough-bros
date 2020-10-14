//
//  HomeViewController.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-09.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var homeView: HomeView {
        return view as! HomeView
    }
    
    // MARK: - View Life Cycle -
    override func loadView() {
        super.loadView()
        
        self.view = HomeView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView.openLoginButton.addTarget(self, action: #selector(openLoginVC), for: .touchUpInside)
    }
    
    
    @objc private func openLoginVC() {
        let loginVC = LoginViewController()
        
        present(loginVC, animated: true)
    }
    
}
