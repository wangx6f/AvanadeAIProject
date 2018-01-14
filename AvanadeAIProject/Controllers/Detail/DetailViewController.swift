//
//  DetailViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/7/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    // MARK: constants
    private let detailTableCellReuseIdentifier = "detailTableCell"
    private let detailTableCellNIBName = "DetailTableCell"
    private let commentTableCellReuseIdentifier = "commentTableCell"
    private let commentTableCellNIBName = "CommentTableCell"
    private let viewCommentTableCellReuseIdentifier = "viewCommentTableCell"
    private let noCommentTableCellReuseIdentifier = "noCommentTableCell"
    
    // MARK: override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return constructDetailCell()
        } else if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            return constructViewCommentCell()
        } else {
            return constructCommentCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    // disable bounce on top edge
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset = CGPoint.zero
        }
    }
    
    // MARK: UI methods
    @IBAction func onBackPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: private methods
    private func tableViewConfig() {
        // register cells
        tableView.register(UINib(nibName: detailTableCellNIBName, bundle: nil), forCellReuseIdentifier: detailTableCellReuseIdentifier)
        tableView.register(UINib(nibName: commentTableCellNIBName, bundle: nil), forCellReuseIdentifier: commentTableCellReuseIdentifier)
        // make the height of cell fit its content
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        // add an inset in the bottom
        tableView.contentInset = UIEdgeInsets(top: CGFloat(0), left: CGFloat(0), bottom: CGFloat(60), right: CGFloat(0))
    }
    
    private func constructDetailCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailTableCellReuseIdentifier) as! DetailTableCell
        return cell
    }
    
    private func constructCommentCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentTableCellReuseIdentifier) as! CommentTableCell
        return cell
    }
    
    private func constructViewCommentCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewCommentTableCellReuseIdentifier)
        return cell!
    }
    
}

