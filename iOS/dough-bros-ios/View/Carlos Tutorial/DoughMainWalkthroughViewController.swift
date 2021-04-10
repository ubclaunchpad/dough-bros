//
//
//  Created by Carlos Georgescu
//  Copyright © 2021 Carlos Georgescu. All rights reserved.
//

import Foundation
import UIKit

class DoughMainWalkthroughViewController: UIViewController {
  @IBOutlet var containerView: UIView!
  @IBOutlet var imageContainerView: UIView!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var subtitleLabel: UILabel!
  
  let model: DoughTutorialModel
  
  init(model: DoughTutorialModel,
       nibName nibNameOrNil: String?,
       bundle nibBundleOrNil: Bundle?) {
    self.model = model
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.image = UIImage.localImage(model.icon)
    imageView.contentMode = .scaleToFill
    imageView.clipsToBounds = true
    imageContainerView.backgroundColor = .clear
    
    titleLabel.text = model.title
    titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
    titleLabel.textColor = .black
    
    subtitleLabel.attributedText = NSAttributedString(string: model.subtitle)
    subtitleLabel.font = UIFont.systemFont(ofSize: 14.0)
    subtitleLabel.textColor = .black
    
    containerView.backgroundColor = UIColor(hexString: model.colorHex)
  }
}
