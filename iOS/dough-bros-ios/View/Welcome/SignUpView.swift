//
//  SignUpView.swift
//  dough-bros-ios
//
//  Created by Stephanie Chen on 2020-11-26.
//

import Foundation
import UIKit
import FBSDKLoginKit
import Firebase

class SignUpView: UIView, UITextFieldDelegate {

    // MARK: - Subviews -
    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Welcome to \nDough Bros"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private var signInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Sign up"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private var loginStack: DBStackView = {
        let stack = DBStackView(axis: .vertical, alignment: .fill, spacing: 50)
        return stack
    }()
    
    private(set) var firstNameTextField: DBTextField = {
        let name = DBTextField(placeholderText: "First Name", textStyle: .body)
        name.styleBottomBorder(color: .black)
        name.returnKeyType = UIReturnKeyType.next
        return name
    }()
    
    private(set) var lastNameTextField: DBTextField = {
        let name = DBTextField(placeholderText: "Last Name", textStyle: .body)
        name.styleBottomBorder(color: .black)
        name.returnKeyType = UIReturnKeyType.next
        return name
    }()
    
    private(set) var emailTextField: DBTextField = {
        let email = DBTextField(placeholderText: "Email", textStyle: .body)
        email.styleBottomBorder(color: .black)
        email.returnKeyType = UIReturnKeyType.next
        return email
    }()
    
    private(set) var passwordTextField: DBTextField = {
        let password = DBTextField(placeholderText: "Password", textStyle: .body)
        password.styleBottomBorder(color: .black)
        password.isSecureTextEntry = true
        password.returnKeyType = UIReturnKeyType.next
        return password
    }()
    
    private(set) var openLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Open Login", for: .normal)
        return button
    }()
    
    private(set) var signUpButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        button.setImage(UIImage(systemName: "arrow.right", withConfiguration: config), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.tintColor = .white
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
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        firstNameTextField.autocorrectionType = .no
        lastNameTextField.autocorrectionType = .no
        emailTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
        
        loginStack.addArrangedSubview(firstNameTextField)
        loginStack.addArrangedSubview(lastNameTextField)
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
            loginStack.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 100),
            firstNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            firstNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            lastNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            lastNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
        
        addSubview(signUpButton)
        NSLayoutConstraint.activate([
            signUpButton.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            signUpButton.topAnchor.constraint(equalTo: loginStack.bottomAnchor, constant: 50),
            signUpButton.heightAnchor.constraint(equalToConstant: 64),
            signUpButton.widthAnchor.constraint(equalToConstant: 64)
        ])
        
        addSubview(signInLabel)
        NSLayoutConstraint.activate([
            signInLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            signInLabel.centerYAnchor.constraint(equalTo: signUpButton.centerYAnchor)
        ])
        
        addSubview(facebookLoginButton)
        NSLayoutConstraint.activate([
            facebookLoginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            facebookLoginButton.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 70)
        ])
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField === firstNameTextField) {
            lastNameTextField.becomeFirstResponder()
        } else if (textField === lastNameTextField) {
            emailTextField.becomeFirstResponder()
        } else if (textField === emailTextField) {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }

}
