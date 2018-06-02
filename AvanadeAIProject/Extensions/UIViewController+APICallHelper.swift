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
                if responseError.statusCode == 401 && handleUnauthorized {
                    routeToLoginOrOut(httpResponseError: responseError)
                }
                else {
                    self.view.makeToast(responseError.description)
                }
            } else {
                self.view.makeToast(_error.localizedDescription)
            }
            return true
        }
        return false
    }
    
    func routeToLoginOrOut(httpResponseError: HTTPResponseError) {
        let alert = UIAlertController(title: "Account Required", message: "In order to perform that action you must login.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { _ in
            if self is DetailViewController {
                self.parent?.performSegue(withIdentifier: "goToLogin", sender: self.parent)
            }
            else {
                self.performSegue(withIdentifier: "goToLogin", sender: self)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            // nothing to do
        }))
        self.present(alert, animated: true)
    }
    
    func logOut() {
        DataManager.sharedInstance.logOut()
    }
}
