//
//  SignInViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/6/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import TransitionButton
class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: TransitionButton!
    private let mainSegueIdentifier = "goToMain"
    @IBOutlet weak var bottomContainer: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configForm()
        configStatusBarBackground(false)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func onLoginPressed(_ sender: TransitionButton) {
        performSegue(withIdentifier: mainSegueIdentifier, sender: self)
        configStatusBarBackground(true)
        
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
