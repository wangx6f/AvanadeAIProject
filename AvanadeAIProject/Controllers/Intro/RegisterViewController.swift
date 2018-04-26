//
//  RegisterViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/7/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import TransitionButton
import Toast_Swift

class RegisterViewController: UIViewController{
    
    private let mainSegueIdentifier = "goToMain"
    
    @IBOutlet weak var formContainer: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configForm()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    
    @IBAction func onCancelPressed(_ sender: TransitionButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func configForm() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        titleTextField.delegate = self
        companyTextField.delegate = self
    }
    
    @IBAction func onRegisterPressed(_ sender: TransitionButton) {
        view.endEditing(true)
        let email = emailTextField.text!, password = passwordTextField.text!,
        firstName = firstNameTextField.text!, lastName = lastNameTextField.text!
        
        if email.count == 0 {
            self.view.makeToast("Email can't be empty.")
            return
        }
        if password.count == 0 {
            self.view.makeToast("Password can't be empty.")
            return
        }
        if firstName.count == 0 {
            self.view.makeToast("First name can't be empty.")
            return
        }
        if lastName.count == 0 {
            self.view.makeToast("Last name can't be empty.")
            return
        }
        
        view.makeToastActivity(ToastPosition.center)
        view.isUserInteractionEnabled = false
        let user = User(email: email, fName: firstName, lName: lastName, title: titleTextField.text!, company: companyTextField.text!)
        DataManager.sharedInstance.register(newUser: user, password: passwordTextField.text!) { (success, message,error) in
            
            self.endWaitactivity()
            if self.handleError(error,handleUnauthorized: false) {
                return
            }
            if success != nil && success! {
                self.view.makeToast("Registered successfully.", duration: TimeInterval(exactly: 2)!, position: ToastPosition.center,completion: { _ in
                    self.performSegue(withIdentifier: self.mainSegueIdentifier, sender: self)
                })
                return
            }
            self.view.makeToast(message)
            
        }
    }
}

extension RegisterViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        formContainer.viewWithTag(textField.tag+1)?.becomeFirstResponder()
        return false
    }
}




