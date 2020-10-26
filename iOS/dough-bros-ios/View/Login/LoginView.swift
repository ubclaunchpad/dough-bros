//
//  LoginView.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-09.
//

import Foundation
import UIKit
import FBSDKLoginKit

class LoginView: UIView {
    
    private(set) var loginButton: FBLoginButton = {
        let loginButton = FBLoginButton()
        loginButton.permissions = ["public_profile", "email"]
        return loginButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(loginButton)
    }
    
    override func layoutSubviews() {
        loginButton.center = center
    }
    
}
