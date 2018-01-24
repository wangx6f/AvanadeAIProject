//
//  AllCommentsViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/13/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

class AllCommentsViewController: UITableViewController {

    
    private let commentDetailSegueIdentifier = "goToCommentDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: commentDetailSegueIdentifier, sender: self)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Constants.commentTableCellReuseIdentifier) as! CommentTableCell
        return cell
    }
    
    
    // MARK: - private methods
    private func tableViewConfig() {
        // register cells
        tableView.register(UINib(nibName: Constants.commentTableCellNIBName, bundle: nil), forCellReuseIdentifier: Constants.commentTableCellReuseIdentifier)
        // make the height of cell fit its content
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
   
    
}
