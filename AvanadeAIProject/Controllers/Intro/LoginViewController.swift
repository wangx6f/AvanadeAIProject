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

class LoginViewController: UIViewController {

    private let mainSegueIdentifier = "goToMain"
    @IBOutlet weak var loginButton: TransitionButton!
    @IBOutlet weak var bottomContainer: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configForm()
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
        self.performSegue(withIdentifier: self.mainSegueIdentifier, sender: self)
        self.configStatusBarBackground(true)
        
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
