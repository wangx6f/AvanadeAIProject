//
//  SignInViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/6/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import TransitionButton
import Toast_Swift
import GoogleSignIn
import FacebookCore
import FacebookLogin

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    public static let mainSegueIdentifier = "goToMain"
    @IBOutlet weak var loginButton: TransitionButton!
    @IBOutlet weak var bottomContainer: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configForm()
        GIDSignIn.sharedInstance().uiDelegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleGoogleLogin(_:)), name: Notification.Name(rawValue: AppDelegate.GoogleLoginNotificationName), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configStatusBarBackground(false)
        autoLogin()
    }
    
    @IBAction func onLoginPressed(_ sender: TransitionButton) {
        view.endEditing(true)
        let email = emailTextField.text!, password = passwordTextField.text!
        if email.count == 0 {
            self.view.makeToast("Email can't be empty.")
            return
        }
        if password.count == 0 {
            self.view.makeToast("Password can't be empty.")
            return
        }
        startWaitActivity()
        DataManager.sharedInstance.login(email: email, password:password ) { (success, message,error) in
            self.endWaitactivity()
            if self.handleError(error,handleUnauthorized: false) {
                return
            }
            
            if success != nil && success! {
                self.login()
                return
            }
            self.view.makeToast(message)
        }
    }
    
    @IBAction func onForgetPasswordPressed(_ sender: UIButton) {
        startWaitActivity()
        DataManager.sharedInstance.getPasswordResetUrl { (url, error) in
            self.endWaitactivity()
            if !self.handleError(error, handleUnauthorized: false) {
                UIApplication.shared.open(URL(string: url!)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc func facebookLoginButtonPressed() {
        
    }
    
    private func configStatusBarBackground(_ backgroundOn:Bool) {
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = backgroundOn ? UIColor.black : UIColor(white:CGFloat(0),alpha:CGFloat(0))
        }
    }
    
    private func configForm() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func autoLogin() {
        if DataManager.sharedInstance.loginStatus() {
            login()
        }
    }
    
    private func login() {
        self.performSegue(withIdentifier: LoginViewController.mainSegueIdentifier, sender: self)
        self.configStatusBarBackground(true)
        
    }
    
    @objc func handleGoogleLogin(_ notification: NSNotification) {
        if let user = notification.userInfo?["user"] as? User {
            DataManager.sharedInstance.updateGoogleProfile(profile: user) { (success, message, error) in
                self.endWaitactivity()
                if self.handleError(error,handleUnauthorized: false) {
                    return
                }
                
                if success != nil && success! {
                    self.login()
                    return
                }
                self.view.makeToast(message)
            }
        }
    }

    @IBAction func facebookButtonDidPress(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.email, .publicProfile], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("Canceled")
            case .success( _,  _,  _):
                self.loginViaFacebook()
            }
        }
    }
    
    private func loginViaFacebook() {
        if let accessToken = AccessToken.current {
            let request = GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, last_name, email"], accessToken: accessToken, httpMethod: .GET, apiVersion: .defaultVersion)
            request.start { (response, result) in
                switch result {
                case .success(let response):
                    if let responseDict = response.dictionaryValue {
                        let myUser = User(email: responseDict["email"] as! String, fName: responseDict["first_name"] as! String, lName: responseDict["last_name"] as! String, title: nil, company: nil)
                        myUser.facebookToken = accessToken.authenticationToken
                        print("we made it")
                        DataManager.sharedInstance.updateFacebookProfile(profile: myUser, completion: { (success, message, error) in
                            self.endWaitactivity()
                            if self.handleError(error,handleUnauthorized: false) {
                                return
                            }
                            
                            if success != nil && success! {
                                self.login()
                                return
                            }
                            self.view.makeToast(message)
                        })
                    }
                case .failed(let error):
                    print("\(error)")
                }
            }
        }
    }
    
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            onLoginPressed(loginButton)
        }
        return false
    }
}
