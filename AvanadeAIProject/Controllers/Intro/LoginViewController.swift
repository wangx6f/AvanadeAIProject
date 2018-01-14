//
//  SignInViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/6/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import TransitionButton
import IHKeyboardAvoiding
class LoginViewController: UIViewController {

    private let mainSegueIdentifier = "goToMain"
    @IBOutlet weak var bottomContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KeyboardAvoiding.avoidingView = bottomContainer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func onLoginPressed(_ sender: TransitionButton) {
        performSegue(withIdentifier: mainSegueIdentifier, sender: self)
    }
    
    
    // TODO: actions for keyboard 'return' pressed

}
