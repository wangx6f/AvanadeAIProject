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
    
    public var comment : Comment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = comment?.reviewer
        content.text = comment?.content

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onBackPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
