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
    }
    
    func endWaitactivity() {
        view.hideToastActivity()
    }
    
    func handleError(_ error:Error?,handleUnauthorized:Bool = true) -> Bool {
        if let _error = error {
            if let responseError = _error as? HTTPResponseError {
                self.view.makeToast("\(responseError.statusCode): \(responseError.description)", completion: { _ in
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
        DataManager.sharedInstance.logOut()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
}
