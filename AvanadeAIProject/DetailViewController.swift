//
//  DetailViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/7/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
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

