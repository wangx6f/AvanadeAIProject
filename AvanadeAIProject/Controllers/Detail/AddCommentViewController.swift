//
//  AddCommentViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/23/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

class AddCommentViewController: UIViewController {

    @IBOutlet weak var commentInputField: UITextField!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onSubmitPressed(_ sender: UIButton) {
        DataManager.sharedInstance.postComment(content: commentInputField.text)
        commentInputField.text = ""
        commentInputField.endEditing(true)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        commentInputField.endEditing(true)
    }
    
    private func config() {
        commentInputField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomConstraint.constant = -keyboardSize.height
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
}

extension AddCommentViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        commentInputField.endEditing(true)
        return false
    }
}
