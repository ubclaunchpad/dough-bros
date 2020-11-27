//
//  WelcomeViewController.swift
//  dough-bros-ios
//
//  Created by Stephanie Chen on 2020-11-26.
//

import Foundation
import UIKit
import FBSDKLoginKit
import Firebase

class WelcomeViewController: UIViewController, LoginButtonDelegate {

    var handle: AuthStateDidChangeListenerHandle?
    
    private var welcomeView: WelcomeView {
        return view as! WelcomeView
    }
    
    private var emailInput: DBTextField {
        return welcomeView.emailTextField as DBTextField
    }
    
    private var passwordInput: DBTextField {
        return welcomeView.passwordTextField as DBTextField
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { [self] (auth, user) in
          print(auth)
            welcomeView.UID.text = user?.uid
        }
    }
    
    // MARK: - View Life Cycle -
    override func loadView() {
        super.loadView()
        
        view = WelcomeView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: 0xE1EEEE)
        
        setUpButtons()
    }
    
    private func setUpButtons() {
        welcomeView.signInButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        welcomeView.resetPasswordButton.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        welcomeView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        welcomeView.facebookLoginButton.delegate = self
    }
    
    @objc func loginAction(sender : UIButton) {
        print(emailInput.text!, passwordInput.text!)
        Auth.auth().signIn(withEmail: emailInput.text!, password: passwordInput.text!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          print(authResult)
            self!.welcomeView.UID.text = authResult?.user.uid
        }
    }
    
    @objc func resetPassword(sender : UIButton) {
        print("reset password")
        // handle functionality
    }
    
    @objc func register(sender: UIButton) {
        print("register new user")
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
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
                  }
                  // User is signed in
                    print(authResult)
                    self.welcomeView.UID.text = authResult?.user.uid
                }
            } else {
                // Login Cancelled or Login Failed
            }

        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {

    }
}
