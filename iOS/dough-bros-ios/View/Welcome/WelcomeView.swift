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

    private(set) var UID: UILabel = {
        let userID = UILabel()
        userID.translatesAutoresizingMaskIntoConstraints = false
        userID.textColor = .black
        userID.text = "???"
        userID.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return userID
    }()
    
    private(set) var TokenID: UILabel = {
        let token = UILabel()
        token.translatesAutoresizingMaskIntoConstraints = false
        token.textColor = .black
        token.text = "???"
        token.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return token
    }()
    
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
    
    private var logoImage: UIImageView = {
        let image = UIImage(named: "Logo")
        let imageView =  UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var signInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Sign in"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private(set) var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private var loginStack: DBStackView = {
        let stack = DBStackView(axis: .vertical, alignment: .fill, spacing: 50)
        return stack
    }()
    
    private(set) var emailTextField: DBTextField = {
        let email = DBTextField(placeholderText: "Email", textStyle: .body)
        email.styleBottomBorder(color: .black)
        email.keyboardType = UIKeyboardType.emailAddress
        email.returnKeyType = UIReturnKeyType.next
        email.clearButtonMode = UITextField.ViewMode.whileEditing
        email.autocorrectionType = .no
        email.autocapitalizationType = .none
        return email
    }()
    
    private(set) var passwordTextField: DBTextField = {
        let password = DBTextField(placeholderText: "Password", textStyle: .body)
        password.styleBottomBorder(color: .black)
        password.isSecureTextEntry = true
        password.keyboardType = UIKeyboardType.default
        password.returnKeyType = UIReturnKeyType.next
        password.clearButtonMode = UITextField.ViewMode.whileEditing
        password.autocorrectionType = .no
        return password
    }()
    
    private(set) var openLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Open Login", for: .normal)
        return button
    }()
    
    private(set) var signInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        button.setImage(UIImage(systemName: "arrow.right", withConfiguration: config), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.tintColor = .white
        button.isEnabled = false
        button.backgroundColor = UIColor(hex: 0xD8D8D8)
        button.addCorners(32)
        return button
    }()
    
    private(set) var facebookLoginButton: FBLoginButton = {
        let fb = FBLoginButton()
        fb.translatesAutoresizingMaskIntoConstraints = false
        fb.permissions = ["public_profile", "email"]
        return fb
    }()
    
    private(set) var resetPasswordButton: UIButton = {
        let resetButton = UIButton()
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setTitleColor(.systemBlue, for: .normal)
        resetButton.setTitle("Reset Password", for: .normal)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        resetButton.setTitleColor(.gray, for: .normal)
        return resetButton
    }()
    
    private(set) var registerButton: UIButton = {
        let register = UIButton()
        register.translatesAutoresizingMaskIntoConstraints = false
        register.setTitleColor(.systemBlue, for: .normal)
        register.setTitle("Register", for: .normal)
        register.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        register.setTitleColor(.gray, for: .normal)
        return register
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
        
        addSubview(logoImage)
        NSLayoutConstraint.activate([
            logoImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            logoImage.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            logoImage.widthAnchor.constraint(equalToConstant: 90),
            logoImage.heightAnchor.constraint(equalToConstant: 90)
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
        
        addSubview(signInButton)
        NSLayoutConstraint.activate([
            signInButton.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            signInButton.topAnchor.constraint(equalTo: loginStack.bottomAnchor, constant: 50),
            signInButton.heightAnchor.constraint(equalToConstant: 64),
            signInButton.widthAnchor.constraint(equalToConstant: 64)
        ])
        
        addSubview(signInLabel)
        NSLayoutConstraint.activate([
            signInLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            signInLabel.centerYAnchor.constraint(equalTo: signInButton.centerYAnchor)
        ])
        
        addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            errorLabel.bottomAnchor.constraint(equalTo: loginStack.topAnchor, constant: -30),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
        
        addSubview(facebookLoginButton)
        NSLayoutConstraint.activate([
            facebookLoginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            facebookLoginButton.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 70)
        ])
        
        addSubview(resetPasswordButton)
        NSLayoutConstraint.activate([
            resetPasswordButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            resetPasswordButton.topAnchor.constraint(equalTo: facebookLoginButton.bottomAnchor, constant: 50)
        ])
        
        addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            registerButton.topAnchor.constraint(equalTo: facebookLoginButton.bottomAnchor, constant: 50)
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField === emailTextField) {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        
        return true
    }

}
