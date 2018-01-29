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
    private let viewCommentTableCellReuseIdentifier = "viewCommentTableCell"
    private let noCommentTableCellReuseIdentifier = "noCommentTableCell"
    private let commentDetailSegueIdentifier = "goToCommentDetail"
    
    // MARK: override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // construct cell for each row
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
    
    // handle the transition to comment detail view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.reuseIdentifier == Constants.commentTableCellReuseIdentifier {
            performSegue(withIdentifier: commentDetailSegueIdentifier, sender: self)
        }
    }
    
    // MARK: UI methods
    @IBAction func onBackPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSharePressed(_ sender: UIBarButtonItem) {
        showActivityVC()
    }
    
    // MARK: private methods
    private func configTableView() {
        // register cells
        tableView.register(UINib(nibName: Constants.detailTableCellNIBName, bundle: nil), forCellReuseIdentifier: Constants.detailTableCellReuseIdentifier)
        tableView.register(UINib(nibName: Constants.commentTableCellNIBName, bundle: nil), forCellReuseIdentifier: Constants.commentTableCellReuseIdentifier)
        // make the height of cell fit its content
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        // add an inset in the bottom
        tableView.contentInset = UIEdgeInsets(top: CGFloat(0), left: CGFloat(0), bottom: CGFloat(60), right: CGFloat(0))
    }
    
    private func constructDetailCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.detailTableCellReuseIdentifier) as! DetailTableCell
        cell.delegate = self
        return cell
    }
    
    private func constructCommentCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.commentTableCellReuseIdentifier) as! CommentTableCell
        return cell
    }
    
    private func constructViewCommentCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewCommentTableCellReuseIdentifier)
        return cell!
    }
    
    private func showActivityVC(){
        //TODO: change the url of the images
    let shareViewController : UIActivityViewController = UIActivityViewController(activityItems: [ShareActivityItemProvider(url: "https://image.ibb.co/bWMupG/Launch_Image.jpg")], applicationActivities: nil)
        present(shareViewController, animated: true, completion:nil)
    }
}

extension DetailViewController : DetailTableCellDelegate {
    
    func didPressRatingStarButton(score: Int, updateButtonsState: @escaping (Int) -> Void) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let attributedString = NSAttributedString(string: getRateAlertMessage(score), attributes: [
            NSAttributedStringKey.font : UIFont(name: "Helvetica Neue", size: CGFloat(18))!
            ])
    
        alert.setValue(attributedString, forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            updateButtonsState(score)
            //TODO: update database
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    func didPressImage(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func didPressBookmark(updateButtonState: (Bool) -> Void) {
        //TODO: update database for bookmark
        updateButtonState(true)
    }
    
    private func getRateAlertMessage(_ score:Int) -> String {
        var stars = ""
        for index in 1...5 {
            if index <= score {
                stars.append("★")
            } else {
                stars.append("☆")
            }
            
        }
        //TODO : change the title
        let title = "\"Title\""
        return "Rate " + title + " with " + stars
    }
    
    
}

