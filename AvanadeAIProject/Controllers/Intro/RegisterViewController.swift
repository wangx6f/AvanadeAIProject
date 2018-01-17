//
//  RegisterViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/7/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import TransitionButton

class RegisterViewController: UIViewController{


    @IBOutlet weak var formContainer: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderTextField: SimplePickerTextField!
    @IBOutlet weak var ageTextField: SimplePickerTextField!
    @IBOutlet weak var majorTextField: SimplePickerTextField!
    
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
        nameTextField.delegate = self
        genderTextField.setOptions(Constants.genderOptions)
        ageTextField.setOptions(Constants.ageOptions)
        majorTextField.setOptions(Constants.majorOptions)
    }
    
}

extension RegisterViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        formContainer.viewWithTag(textField.tag+1)?.becomeFirstResponder()
        return false
    }
}




