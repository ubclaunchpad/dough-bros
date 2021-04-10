//
//
//  Created by Carlos Georgescu
//  Copyright © 2021 Carlos Georgescu. All rights reserved.
//

import UIKit
import Foundation

class CarlosViewController: UIViewController, DoughWalkthroughViewControllerDelegate {
    let walkthroughs = [
        DoughTutorialModel(title: "Home Page", subtitle: "filters/recent users/ outstanding payments ", icon: "tutorial-home", color: "#fffee3"),
        DoughTutorialModel(title: "Create Group", subtitle: "search for someone thats not your friend (by name or email)", icon: "turorial-addFriend", color: "#d4f6fd"),
        DoughTutorialModel(title: "Add Expense", subtitle: "Vdont allow to change the total amount for custom mode??", icon: "tutorial-addExpense", color: "#cbffc9"),
        DoughTutorialModel(title: "Settle Debt", subtitle: "Groupe Details / Settle Debts", icon: "tutorial-debt", color: "#fde3f9")
    ]
    
    var tutorialDelegate: CarlosTutorialDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        let walkthroughVC = self.walkthroughVC()
        walkthroughVC.delegate = self
        self.addChildViewControllerWithView(walkthroughVC)
    }

    func walkthroughViewControllerDidFinishFlow(_ vc: DoughWalkthroughViewController) {
        UIView.transition(with: self.view, duration: 1, options: .transitionFlipFromLeft, animations: {
          vc.view.removeFromSuperview()
        }, completion: { [self] _ in
            if let delegate = self.tutorialDelegate {
                delegate.dismissTutorial()
            }
        })
    }

    fileprivate func walkthroughVC() -> DoughWalkthroughViewController {
        let viewControllers = walkthroughs.map { DoughMainWalkthroughViewController(model: $0, nibName: "DoughClassicWalkthroughViewController", bundle: nil) }
        return DoughWalkthroughViewController(nibName: "DoughWalkthroughViewController",
                                            bundle: nil,
                                            viewControllers: viewControllers)
    }
}
