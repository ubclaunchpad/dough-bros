//
//  TutorialViewController.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-25.
//

import UIKit

class TutorialViewController: UIPageViewController {

    /*
     TODO: Implement this class, note this controller subclasses UIPageViewController, often used to setup tutorials!
     
     Checkout apple documentation on UIPageViewController and ask if you have questions!
     */
    private var groupsView: TutorialView {
        return view as! TutorialView
    }
    
    // MARK: - View Life Cycle -
    override func loadView() {
        super.loadView()
        
        view = TutorialView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
