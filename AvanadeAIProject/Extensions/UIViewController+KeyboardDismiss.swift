//
//  UIViewController+KeyboardDismiss.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/9/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)  //handle the dismiss of keyboard when anywhere outside the textfileds is touched
    }
    
}
