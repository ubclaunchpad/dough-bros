//
//
//  Created by Carlos Georgescu
//  Copyright © 2021 Carlos Georgescu. All rights reserved.
//

import UIKit
import Foundation

class CarlosViewController: UIViewController, DoughWalkthroughViewControllerDelegate {
  let walkthroughs = [
    DoughTutorialModel(title: "Quick Overview", subtitle: "Quickly visualize important business metrics. The overview in the home tab shows the most important metrics to monitor how your business is doing in real time.", icon: "analytics-icon", color: "#fffee3"),
    DoughTutorialModel(title: "Analytics", subtitle: "Dive deep into charts to extract valuable insights and come up with data driven product initiatives, to boost the success of your business.", icon: "bars-icon", color: "#d4f6fd"),
    DoughTutorialModel(title: "Dashboard Feeds", subtitle: "View your sales feed, orders, customers, products and employees.", icon: "activity-feed-icon", color: "#cbffc9"),
    DoughTutorialModel(title: "Get Notified", subtitle: "Receive notifications when critical situations occur to stay on top of everything important.", icon: "bell-icon", color: "#fde3f9"),
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let walkthroughVC = self.walkthroughVC()
    walkthroughVC.delegate = self
    self.addChildViewControllerWithView(walkthroughVC)
  }
  
  func walkthroughViewControllerDidFinishFlow(_ vc: DoughWalkthroughViewController) {
    UIView.transition(with: self.view, duration: 1, options: .transitionFlipFromLeft, animations: {
      vc.view.removeFromSuperview()
      let viewControllerToBePresented = UIViewController()
      self.view.addSubview(viewControllerToBePresented.view)
    }, completion: nil)
  }
  
  fileprivate func walkthroughVC() -> DoughWalkthroughViewController {
    let viewControllers = walkthroughs.map { DoughMainWalkthroughViewController(model: $0, nibName: "DoughClassicWalkthroughViewController", bundle: nil) }
    return DoughWalkthroughViewController(nibName: "DoughWalkthroughViewController",
                                        bundle: nil,
                                        viewControllers: viewControllers)
  }
}
