//
//  SettingsForm.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/11/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import Eureka

class SettingsForm: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configForm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //config the section footer height to be 0
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    
    //MARK: private method
    private func configForm() {
        
        navigationOptions = RowNavigationOptions.Disabled
        
        form +++ Section("Profile")
            <<< NameRow() { row in
                    row.title = "Name"
                    row.value = "John Smith"
            }
            <<< PushRow<String>() { row in
                row.title = "Gender"
                row.value = "Male"
                row.options = ["Male","Female","Other"]
                row.selectorTitle = "Gender"
                }
            <<< PushRow<String>() { row in
                row.title = "Major"
                row.value = "Business"
                row.options = ["Business","Computer Science","Civil Engineering"]
                row.selectorTitle = "Major"
        }
            
        +++ Section("Support")
            <<< LabelRow() { row in
                    row.title = "Help & Feedback"
                    row.baseCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                    row.baseCell.selectionStyle = UITableViewCellSelectionStyle.gray
                row.onCellSelection({ (cell, row) in
                    cell.setSelected(false, animated: true)
                    //TODO: push the help & feedback page
                })
        }
            <<< LabelRow() { row in
                row.title = "About"
                row.baseCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                row.baseCell.selectionStyle = UITableViewCellSelectionStyle.gray
                row.onCellSelection({ (cell, row) in
                    cell.setSelected(false, animated: true)
                    //TODO: push the about page
                })
        }
        
        form +++ ButtonRow() { row in
                row.title = "Clear Search History"
                row.onCellSelection({ _,_ in
                    //TODO: do necessary operation to clear the search history
                })
            }
        
         form +++ ButtonRow() { row in
                row.title = "Log Out"
                row.onCellSelection({ _,_ in
                    //TODO: do necessary operation to log out
                })
            }
    }


}
