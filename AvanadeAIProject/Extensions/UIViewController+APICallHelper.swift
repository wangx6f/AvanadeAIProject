//
//  UIViewController+WaitActivity.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 2/4/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import Toast_Swift

extension UIViewController {
    
    func startWaitActivity(){
        view.endEditing(true)
        view.makeToastActivity(ToastPosition.center)
        view.isUserInteractionEnabled = false
    }
    
    func endWaitactivity() {
        view.hideToastActivity()
        view.isUserInteractionEnabled = true
    }
    
    func handleError(_ error:Error?,handleUnauthorized:Bool = true) -> Bool {
        if let _error = error {
            if let responseError = _error as? HTTPResponseError {
                // TODO: compile the http status code
                self.view.makeToast(String(responseError.statusCode), completion: { _ in
                    if responseError.statusCode == 401 && handleUnauthorized {
                        self.logOut()
                    }
                })
            } else {
                self.view.makeToast(_error.localizedDescription)
            }
            return true
        }
        return false
    }
    
    func logOut() {
        // TODO: call data manager to log out
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
