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

    private let mainSegueIdentifier = "goToMain"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func onLoginPressed(_ sender: TransitionButton) {
        performSegue(withIdentifier: mainSegueIdentifier, sender: self)
    }
    
    
    // TODO: actions for keyboard 'return' pressed

}
