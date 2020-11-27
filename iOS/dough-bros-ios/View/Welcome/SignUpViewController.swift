//
//  SignUpViewController.swift
//  dough-bros-ios
//
//  Created by Stephanie Chen on 2020-11-26.
//

import UIKit

class SignUpViewController: UIViewController {

    private var homeView: SignUpView {
        return view as! SignUpView
    }
    
    // MARK: - View Life Cycle -
    override func loadView() {
        super.loadView()
        
        view = SignUpView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: 0xE1EEEE)
    }

}
