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

    // MARK: override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return constructDetailCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // MARK: UI methods
    @IBAction func onBackPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: private methods
    private func tableViewConfig() {
        tableView.register(UINib(nibName: detailTableCellNIBName, bundle: nil), forCellReuseIdentifier: detailTableCellReuseIdentifier)
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.layoutMargins = UIEdgeInsets.zero
    }
    
    private func constructDetailCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailTableCellReuseIdentifier) as! DetailTableCell
//        cell.setImageRatio(CGFloat(0.5))
        return cell
    }
}

