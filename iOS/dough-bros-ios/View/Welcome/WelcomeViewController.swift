//
//  WelcomeViewController.swift
//  dough-bros-ios
//
//  Created by Stephanie Chen on 2020-11-26.
//

import UIKit

class WelcomeViewController: UIViewController {

    private var homeView: WelcomeView {
        return view as! WelcomeView
    }
    
    // MARK: - View Life Cycle -
    override func loadView() {
        super.loadView()
        
        view = WelcomeView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: 0xE1EEEE)
    }
    
    //

}
