//
//  LoginViewController.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-09.
//

import UIKit
import FBSDKLoginKit
import Firebase


class LoginViewController: UIViewController, LoginButtonDelegate {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    private var loginView: LoginView {
        return view as! LoginView
    }
    
    override func loadView() {
        super.loadView()
        self.view = LoginView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { [self] (auth, user) in
          print(auth)
            loginView.UID.text = user?.uid
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    // TODO: Implement Mock Login View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        if let token = AccessToken.current,
            !token.isExpired {
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields": "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            request.start(completionHandler: { connection, result, error in
            print("\(result)")
            })
        }

        loginView.loginButton.delegate = self
        view.addSubview(loginView.loginButton)

    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString

        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        request.start(completionHandler: { connection, result, error in
            print("\(result)")
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
                    self.loginView.UID.text = authResult?.user.uid
                }
            } else {
                // Login Cancelled or Login Failed
            }

        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {

    }
}
