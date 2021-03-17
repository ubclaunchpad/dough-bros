//
//  SignUpViewController.swift
//  dough-bros-ios
//
//  Created by Stephanie Chen on 2020-11-26.
//

import Foundation
import UIKit
import FBSDKLoginKit
import Firebase

class SignUpViewController: UIViewController, LoginButtonDelegate {

    var handle: AuthStateDidChangeListenerHandle?
    
    private var signupView: SignUpView {
        return view as! SignUpView
    }
    
    private var firstNameInput: DBTextField {
        return signupView.firstNameTextField as DBTextField
    }
    
    private var lastNameInput: DBTextField {
        return signupView.lastNameTextField as DBTextField
    }
    
    private var emailInput: DBTextField {
        return signupView.emailTextField as DBTextField
    }
    
    private var passwordInput: DBTextField {
        return signupView.passwordTextField as DBTextField
    }
    
    // MARK: - View Life Cycle -
    override func loadView() {
        super.loadView()
        
        view = SignUpView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: 0xE1EEEE)
        setUpButtons()
        setUpEmptyTextFieldValidation()
    }

    private func setUpButtons() {
        signupView.signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        signupView.facebookLoginButton.delegate = self
    }
    
    private func setUpEmptyTextFieldValidation() {
        firstNameInput.addTarget(self, action: #selector(textFieldsNotEmpty), for: .editingChanged)
        lastNameInput.addTarget(self, action: #selector(textFieldsNotEmpty), for: .editingChanged)
        emailInput.addTarget(self, action: #selector(textFieldsNotEmpty), for: .editingChanged)
        emailInput.addTarget(self, action: #selector(emailInputDidChange(_:)), for: .editingChanged)
        passwordInput.addTarget(self, action: #selector(textFieldsNotEmpty), for: .editingChanged)
        passwordInput.addTarget(self, action: #selector(passwordInputDidChange(_:)), for: .editingChanged)

    }
    
    @objc func textFieldsNotEmpty(sender: UITextField) {
        if let firstName = firstNameInput.text, !firstName.isEmpty,
           let lastName = lastNameInput.text, !lastName.isEmpty,
           let email = emailInput.text, !email.isEmpty,
           let password = passwordInput.text, !password.isEmpty {
            let validPassword = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[A-Z])(?=.*[a-z])(?=.*[$@$#!%*?&.]).{8,}$")
            if (validPassword.evaluate(with: password)) {
                signupView.signUpButton.backgroundColor = UIColor(hex: 0xF8A096)
                signupView.signUpButton.isEnabled = true
            }
        } else {
            signupView.signUpButton.backgroundColor = UIColor(hex: 0xD8D8D8)
            signupView.signUpButton.isEnabled = false
        }
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
       
       var returnValue = true
       let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
       
       do {
           let regex = try NSRegularExpression(pattern: emailRegEx)
           let nsString = emailAddressString as NSString
           let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
           
           if results.count == 0
           {
               returnValue = false
           }
           
       } catch let error as NSError {
           print("invalid regex: \(error.localizedDescription)")
           returnValue = false
       }
       
       return  returnValue
    }
    
    @objc func emailInputDidChange(_ textField: DBTextField) {
        if (!isValidEmailAddress(emailAddressString: textField.text!)) {
            textField.styleBottomBorder(color: .red)
        } else {
            textField.styleBottomBorder(color: .black)
        }
    }
    
    @objc func passwordInputDidChange(_ textField: DBTextField) {
        let validPassword = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[A-Z])(?=.*[a-z])(?=.*[$@$#!%*?&.]).{8,}$")
        if (!validPassword.evaluate(with: textField.text)) {
            textField.styleBottomBorder(color: .red)
        } else {
            textField.styleBottomBorder(color: .black)
        }
    }
    
    @objc func signUpAction(sender : UIButton) {
        print("creating new user in Firebase :)")
        Auth.auth().createUser(withEmail: emailInput.text!, password: passwordInput.text!) { [self] authResult, error in
            if let err = error {
                print("ERROR: \(err)")
                return
            }
            
            guard let result = authResult else {
                print("authResult is null")
                return
            }
            
            self.getToken(uid: result.user.uid)
            
            let groupVC = GroupsViewController()
            groupVC.showTutorial = true
            self.navigationController?.pushViewController(groupVC, animated: true)
        }
    }
    
    private func getToken(uid: String?) {
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
            guard let uid = uid else {
                return
            }
            let user = User(firebase_uid: uid, first_name: self.firstNameInput.text!, last_name: self.lastNameInput.text!, email_addr: self.emailInput.text!, facebook_id: "", is_anon: 0, fcm_token: token)
            UserEndpoints.createUser(user: user)
          }
        }
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString

        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        request.start(completionHandler: { connection, result, error in
            print("\(String(describing: result))")
            if (token != nil) {
                let credential = FacebookAuthProvider.credential(withAccessToken: token!)
                
                // Convert to Firebase
                Auth.auth().signIn(with: credential) { (authResult, error) in
                  if let error = error {
                    let authError = error as NSError
                    return
                  } else {
                    self.navigationController?.pushViewController(GroupsViewController(), animated: true)
                  }
                  // User is signed in
                    print(authResult)
                }
            } else {
                // Login Cancelled or Login Failed
            }

        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {

    }
}
