//
//
//  Created by Carlos Georgescu
//  Copyright © 2021 Carlos Georgescu. All rights reserved.
//

import Foundation
import UIKit

protocol DoughWalkthroughViewControllerDelegate: class {
  func walkthroughViewControllerDidFinishFlow(_ vc: DoughWalkthroughViewController)
}

class DoughWalkthroughViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
  @IBOutlet var pageControl: UIPageControl!
  
  weak var delegate: DoughWalkthroughViewControllerDelegate?
  
  let viewControllers: [UIViewController]
  var pageIndex = 0
  let pageController: UIPageViewController
  let fakeVC: UIViewController
  
  init(nibName nibNameOrNil: String?,
       bundle nibBundleOrNil: Bundle?,
       viewControllers: [UIViewController]) {
    self.viewControllers = viewControllers
    self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    self.fakeVC = UIViewController()
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.pageController.dataSource = self
    self.pageController.delegate = self
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    pageController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
    self.addChildViewControllerWithView(pageController)
    pageControl.numberOfPages = viewControllers.count
    pageControl.pageIndicatorTintColor = UIColor.black
    pageControl.currentPageIndicatorTintColor = UIColor.systemPink
    self.view.bringSubviewToFront(pageControl)
    super.viewDidLoad()
  }
  
  public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    if let index = self.index(of: viewController) {
      if index == 0 {
        return nil
      }
      return viewControllers[index - 1]
    }
    return nil
  }
  
  public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    if let index = self.index(of: viewController) {
      if index + 1 >= viewControllers.count {
        return fakeVC
      }
      return viewControllers[index + 1]
    }
    return nil
  }
  
  public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    if !completed {
      return
    }
    if let lastPushedVC = pageViewController.viewControllers?.last {
      if let index = index(of: lastPushedVC) {
        pageControl.currentPage = index
      } else {
      }
    }
  }
  
  public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
    if pendingViewControllers.first == self.fakeVC {
      self.removeChildViewController(self.pageController)
      self.delegate?.walkthroughViewControllerDidFinishFlow(self)
    }
  }
  
  private func index(of viewController: UIViewController) -> Int? {
    for (index, vc) in viewControllers.enumerated() {
      if viewController == vc {
        return index
      }
    }
    return nil
  }
}
