//
//  SettingsForm.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/11/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import Eureka
import AcknowList

class SettingsFormController: FormViewController {

    private let aboutSegueIdentifier = "goToAbout"
    
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
    
    
    // MARK: private methods
    private func configForm() {
        
        navigationOptions = RowNavigationOptions.Disabled
        
        form +++ Section("Profile")
            <<< NameRow() { row in
                    row.title = "Name"
                    row.value = "John Smith"
            }
            <<< PushRow<String>() { row in
                row.title = "Gender"
                row.value = Constants.genderOptions[0]
                row.options = Constants.genderOptions
                row.selectorTitle = "Gender"
                _ = row.onPresent({ (from, to) in
                    to.enableDeselection = false
                })
                }
            <<< PushRow<String>() { row in
                row.title = "Age"
                row.value = Constants.ageOptions[0]
                row.options = Constants.ageOptions
                row.selectorTitle = "Age"
                _ = row.onPresent({ (from, to) in
                    to.enableDeselection = false
                })
            }

            <<< PushRow<String>() { row in
                row.title = "Major"
                row.value = Constants.majorOptions[0]
                row.options = Constants.majorOptions
                row.selectorTitle = "Major"
                _ = row.onPresent({ (from, to) in
                    to.enableDeselection = false
                })
        }
            
        +++ Section("Support")
            <<< LabelRow() { row in
                row.title = "About"
                row.baseCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                row.baseCell.selectionStyle = UITableViewCellSelectionStyle.gray
                row.onCellSelection({ (cell, row) in
                    cell.setSelected(false, animated: true)
                    self.performSegue(withIdentifier: self.aboutSegueIdentifier, sender: self)
                })
                
        }
            <<< LabelRow() { row in
                row.title = "Acknowledgements"
                row.baseCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                row.baseCell.selectionStyle = UITableViewCellSelectionStyle.gray
                row.onCellSelection({ (cell, row) in
                    cell.setSelected(false, animated: true)
                    self.showAcknowledgements()
                })
        }
        
        form +++ ButtonRow() { row in
                row.title = "Clear Search History"
                row.onCellSelection({ _,_ in
                    // TODO: do necessary operation to clear the search history
                })
        }
        
         form +++ ButtonRow() { row in
                row.title = "Log Out"
                row.onCellSelection({ _,_ in
                    // TODO: do necessary operation to log out
                })
        }
    }
    
    private func showAcknowledgements(){
        let viewController = AcknowListViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
