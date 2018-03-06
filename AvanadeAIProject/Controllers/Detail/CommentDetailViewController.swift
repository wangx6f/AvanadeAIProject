//
//  CommentDetailViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/14/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

class CommentDetailViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    public var comment : Comment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = comment?.reviewer
        content.text = comment?.content
        if (comment?.editable)! {
            deleteButton.title = "Delete"
        } else {
            deleteButton.title = "Report"
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onDeletePressed(_ sender: UIBarButtonItem) {
        if(comment?.editable)! {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let attributedString = NSAttributedString(string: "Are you sure to delete this comment?", attributes: [
                NSAttributedStringKey.font : UIFont(name: "Helvetica Neue", size: CGFloat(18))!
                ])
            
            alert.setValue(attributedString, forKey: "attributedTitle")
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: { (action) in
                DataManager.sharedInstance.deleteComment(comment: self.comment, completion: { (error) in
                    if !self.handleError(error) {
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }))
            present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let attributedString = NSAttributedString(string: "Are you sure to report this comment for inappropriate content?", attributes: [
                NSAttributedStringKey.font : UIFont(name: "Helvetica Neue", size: CGFloat(18))!
                ])
            
            alert.setValue(attributedString, forKey: "attributedTitle")
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: { (action) in
                DataManager.sharedInstance.reportComment(comment: self.comment, completion: { (error) in
                    if !self.handleError(error) {
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func onBackPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
