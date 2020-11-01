//
//  TutorialViewController.swift
//  dough-bros-ios
//
//  Created by Carlos Georgescu on 2020-10-31.
//

import UIKit

class TutorialViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        self.view = TutorialView()
    }
    override func viewDidLoad() {
    view.backgroundColor = UIColor.blue;
    
    }
    
}

