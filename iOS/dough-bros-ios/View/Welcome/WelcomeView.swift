//
//  WelcomeView.swift
//  dough-bros-ios
//
//  Created by Stephanie Chen on 2020-11-26.
//

import Foundation
import UIKit
import FBSDKLoginKit
import Firebase

class WelcomeView: UIView, UITextFieldDelegate {

    // MARK: - Subviews -
    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 20
        let attrString = NSMutableAttributedString(string: "Welcome to \nDough Bros")
        attrString.addAttribute(.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private var signInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Sign in"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private var loginStack: DBStackView = {
        let stack = DBStackView(axis: .vertical, alignment: .fill, spacing: 50)
        return stack
    }()
    
    private var emailTextField: DBTextField = {
        let email = DBTextField(placeholderText: "Email", textStyle: .body)
        email.styleBottomBorder(color: .black)
        return email
    }()
    
    private var passwordTextField: DBTextField = {
        let password = DBTextField(placeholderText: "Password", textStyle: .body)
        password.styleBottomBorder(color: .black)
        return password
    }()
    
    private(set) var openLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Open Login", for: .normal)
        return button
    }()
    
    private(set) var facebookLoginButton: FBLoginButton = {
        let fb = FBLoginButton()
        fb.translatesAutoresizingMaskIntoConstraints = false
        fb.permissions = ["public_profile", "email"]
        return fb
    }()
    
    //MARK: - Initializers -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        setupView()
    }
    
    // REQUIRED implementation for loading views from cached storyboards since we implemented another init we need to cover the required inits, we will never use this method though
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    private func setupStackView() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
        
        loginStack.addArrangedSubview(emailTextField)
        loginStack.addArrangedSubview(passwordTextField)
    }
    
    // MARK: - Setup -
    private func setupView() {
        backgroundColor = .white
        addSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            welcomeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 150),
        ])
        
        addSubview(loginStack)
        NSLayoutConstraint.activate([
            loginStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginStack.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 150),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
        
        addSubview(signInLabel)
        NSLayoutConstraint.activate([
            signInLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            signInLabel.topAnchor.constraint(equalTo: loginStack.bottomAnchor, constant: 50)
        ])
        
        addSubview(facebookLoginButton)
        NSLayoutConstraint.activate([
            facebookLoginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            facebookLoginButton.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 50)
        ])
    }

}
