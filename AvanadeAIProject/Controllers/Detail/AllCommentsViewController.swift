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
    
    private var commentList : [Comment]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case commentDetailSegueIdentifier?:
            let commentDetailView : CommentDetailViewController = segue.destination as! CommentDetailViewController
            commentDetailView.comment = sender as? Comment
            break
        default:
            break
        }
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: commentDetailSegueIdentifier, sender: commentList?[indexPath.row])
    }
    
    @IBAction func onBackPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (commentList?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return constructCommentCell(commentList![indexPath.row])
    }
    
    
    // MARK: - private methods
    private func tableViewConfig() {
        // register cells
        tableView.register(UINib(nibName: Constants.commentTableCellNIBName, bundle: nil), forCellReuseIdentifier: Constants.commentTableCellReuseIdentifier)
        // make the height of cell fit its content
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func constructCommentCell(_ comment:Comment) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.commentTableCellReuseIdentifier) as! CommentTableCell
        cell.content.text = comment.content
        cell.name.text = comment.reviewer
        return cell
    }
   
}

extension AllCommentsViewController : CommentListDelegate {
    func refreshCommentList(commentList: [Comment]?) {
        self.commentList = commentList
        self.tableView.reloadData()
    }
    
    func errorDidOccur(_ error: Error) {
        _ = self.handleError(error)
    }
    
    
}
