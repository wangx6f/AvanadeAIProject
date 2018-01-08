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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLoginPressed(_ sender: TransitionButton) {
    
        sender.startAnimation()
        sender.stopAnimation(animationStyle: .expand, revertAfterDelay: 0) {
            self.performSegue(withIdentifier: "goToMainScene", sender: self)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)  //handle the dismiss of keyboard when anywhere outside the textfileds is touched
    }
    
    // TODO: actions for keyboard 'return' pressed

}
