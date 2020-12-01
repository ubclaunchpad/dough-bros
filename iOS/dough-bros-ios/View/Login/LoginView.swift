//
//  LoginView.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-09.
//

import Foundation
import UIKit
import FBSDKLoginKit
import Firebase

class LoginView: UIView {
    
    // Subviews
    public var UID: UILabel = {
        let userID = UILabel()
        userID.translatesAutoresizingMaskIntoConstraints = false
        userID.textColor = .black
        userID.text = "???"
        userID.font = UIFont.customFont(ofSize: 20, weight: .bold)
        return userID
    }()
    
    public var TokenID: UILabel = {
        let token = UILabel()
        token.translatesAutoresizingMaskIntoConstraints = false
        token.textColor = .black
        token.text = "???"
        token.font = UIFont.customFont(ofSize: 20, weight: .bold)
        return token
    }()
    
    private var firstNameInput: UITextField = {
        let firstName = UITextField()
        firstName.translatesAutoresizingMaskIntoConstraints = false
        firstName.placeholder = "First Name"
        firstName.font = UIFont.customFont(ofSize: 15)
        firstName.borderStyle = UITextField.BorderStyle.roundedRect
        firstName.autocorrectionType = UITextAutocorrectionType.no
        firstName.keyboardType = UIKeyboardType.default
        firstName.returnKeyType = UIReturnKeyType.next
        firstName.clearButtonMode = UITextField.ViewMode.whileEditing
        firstName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return firstName
    }()
    
    private var lastNameInput: UITextField = {
        let lastName = UITextField()
        lastName.translatesAutoresizingMaskIntoConstraints = false
        lastName.placeholder = "Last Name"
        lastName.font = UIFont.customFont(ofSize: 15)
        lastName.borderStyle = UITextField.BorderStyle.roundedRect
        lastName.autocorrectionType = UITextAutocorrectionType.no
        lastName.keyboardType = UIKeyboardType.default
        lastName.returnKeyType = UIReturnKeyType.next
        lastName.clearButtonMode = UITextField.ViewMode.whileEditing
        lastName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return lastName
    }()
    
    private var emailInput: UITextField = {
        let email = UITextField()
        email.translatesAutoresizingMaskIntoConstraints = false
        email.placeholder = "Email"
        email.font = UIFont.customFont(ofSize: 15)
        email.borderStyle = UITextField.BorderStyle.roundedRect
        email.autocorrectionType = UITextAutocorrectionType.no
        email.keyboardType = UIKeyboardType.emailAddress
        email.returnKeyType = UIReturnKeyType.next
        email.clearButtonMode = UITextField.ViewMode.whileEditing
        email.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return email
    }()
    
    private var passwordInput: UITextField = {
        let pass = UITextField()
        pass.translatesAutoresizingMaskIntoConstraints = false
        pass.placeholder = "Password"
        pass.font = UIFont.customFont(ofSize: 15)
        pass.borderStyle = UITextField.BorderStyle.roundedRect
        pass.autocorrectionType = UITextAutocorrectionType.no
        pass.keyboardType = UIKeyboardType.default
        pass.returnKeyType = UIReturnKeyType.next
//        pass.isSecureTextEntry = true
        pass.clearButtonMode = UITextField.ViewMode.whileEditing
        pass.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return pass
    }()
    
    private var confirmPasswordInput: UITextField = {
        let confirm = UITextField()
        confirm.translatesAutoresizingMaskIntoConstraints = false
        confirm.placeholder = "Confirm Password"
        confirm.font = UIFont.customFont(ofSize: 15)
        confirm.borderStyle = UITextField.BorderStyle.roundedRect
        confirm.autocorrectionType = UITextAutocorrectionType.no
        confirm.keyboardType = UIKeyboardType.default
        confirm.returnKeyType = UIReturnKeyType.done
//        confirm.isSecureTextEntry = true
        confirm.clearButtonMode = UITextField.ViewMode.whileEditing
        confirm.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return confirm
    }()
    
    private var signUpButton: UIButton = {
        let signUp = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        signUp.translatesAutoresizingMaskIntoConstraints = false
        signUp.tintColor = .blue
        signUp.backgroundColor = .black
        signUp.setTitleColor(.white, for: .normal)
        signUp.setTitle("Sign Up", for: .normal)
        signUp.layer.cornerRadius = 8
        signUp.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        return signUp
    }()
    
    private var goLoginButton: UIButton = {
        let login = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        login.translatesAutoresizingMaskIntoConstraints = false
        login.tintColor = .blue
        login.setTitleColor(.black, for: .normal)
        login.setTitle("Login", for: .normal)
        login.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return login
    }()
    
    private var logoutButton: UIButton = {
        let logoutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.tintColor = .blue
        logoutButton.backgroundColor = .black
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.layer.cornerRadius = 8
        logoutButton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        return logoutButton
    }()
    
    private(set) var loginButton: FBLoginButton = {
        let fb = FBLoginButton()
        fb.permissions = ["public_profile", "email"]
        return fb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func signUpAction(sender : UIButton) {
        Auth.auth().createUser(withEmail: emailInput.text!, password: passwordInput.text!) { [self] authResult, error in
          print(authResult)
            self.UID.text = authResult?.user.uid
            self.getToken()
        }
    }
    
    @objc func loginAction(sender : UIButton) {
        Auth.auth().signIn(withEmail: emailInput.text!, password: passwordInput.text!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          print(authResult)
            self!.UID.text = authResult?.user.uid
            self!.getToken()
        }
    }
    
    private func getToken() {
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
            self.TokenID.text  = "Remote FCM registration token: \(token)"
            let user = User(firebase_uid: self.UID.text!, first_name: self.firstNameInput.text!, last_name: self.lastNameInput.text!, email_addr: self.emailInput.text!, facebook_id: "", is_anon: 0, fcm_token: token)
            UserEndpoints.createUser(user: user)
          }
        }
    }
    
    @objc func logoutAction(sender : UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("logged out")
            self.UID.text = "???"
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    func setupView() {
        // setupLoginButton()
        addSubview(goLoginButton)
        NSLayoutConstraint.activate([
            goLoginButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            goLoginButton.widthAnchor.constraint(equalToConstant: 100),
            goLoginButton.heightAnchor.constraint(equalToConstant: 30),
            goLoginButton.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        // setupSignUpInputs()
        addSubview(firstNameInput)
        firstNameInput.delegate = self
        NSLayoutConstraint.activate([
            firstNameInput.topAnchor.constraint(equalTo: goLoginButton.bottomAnchor, constant: 30),
            firstNameInput.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            firstNameInput.heightAnchor.constraint(equalToConstant: 30),
            firstNameInput.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        addSubview(lastNameInput)
        lastNameInput.delegate = self
        NSLayoutConstraint.activate([
            lastNameInput.topAnchor.constraint(equalTo: firstNameInput.bottomAnchor, constant: 10),
            lastNameInput.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            lastNameInput.heightAnchor.constraint(equalToConstant: 30),
            lastNameInput.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        addSubview(emailInput)
        emailInput.delegate = self
        NSLayoutConstraint.activate([
            emailInput.topAnchor.constraint(equalTo: lastNameInput.bottomAnchor, constant: 10),
            emailInput.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            emailInput.heightAnchor.constraint(equalToConstant: 30),
            emailInput.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        addSubview(passwordInput)
        passwordInput.delegate = self
        NSLayoutConstraint.activate([
            passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 10),
            passwordInput.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            passwordInput.heightAnchor.constraint(equalToConstant: 30),
            passwordInput.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        addSubview(confirmPasswordInput)
        confirmPasswordInput.delegate = self
        NSLayoutConstraint.activate([
            confirmPasswordInput.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 10),
            confirmPasswordInput.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            confirmPasswordInput.heightAnchor.constraint(equalToConstant: 30),
            confirmPasswordInput.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])

        // signUpButton
        addSubview(signUpButton)
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordInput.bottomAnchor, constant: 10),
            signUpButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])

        // setupFBButton
        addSubview(loginButton)
        
        // User Info
        addSubview(UID)
        NSLayoutConstraint.activate([
            UID.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 50),
            UID.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        addSubview(TokenID)
        NSLayoutConstraint.activate([
            TokenID.topAnchor.constraint(equalTo: UID.bottomAnchor, constant: 10),
            TokenID.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: TokenID.bottomAnchor, constant: 10),
            logoutButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    override func layoutSubviews() {
        loginButton.center = center
        
    }
    
}

extension LoginView: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        textField.resignFirstResponder()
        return true
    }

}
