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
import Toast_Swift

class SettingsFormController: FormViewController {

    private let aboutSegueIdentifier = "goToAbout"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configForm()
        reloadProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //config the section footer height to be 0
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    @IBAction func onSavePressed(_ sender: UIBarButtonItem) {
        saveProfile()   
    }
    
    @IBAction func onRefreshPressed(_ sender: UIBarButtonItem) {
        reloadProfile()
    }
    
    // MARK: private methods
    private func configForm() {
        
        navigationOptions = RowNavigationOptions.Disabled
        
        form +++ Section("Profile")
            <<< NameRow() { row in
                    row.tag = User.JSON_FIRST_NAME
                    row.title = "First Name"
            }
            <<< NameRow() { row in
                row.tag = User.JSON_LAST_NAME
                row.title = "Last Name"
            }
            <<< PushRow<String>() { row in
                row.tag = User.JSON_GENDER
                row.title = "Gender"
                row.options = Constants.genderOptions
                row.selectorTitle = "Gender"
                _ = row.onPresent({ (from, to) in
                    to.enableDeselection = false
                })
                }
            <<< PushRow<String>() { row in
                row.tag = User.JSON_AGE
                row.title = "Age"
                row.options = Constants.ageOptions
                row.selectorTitle = "Age"
                _ = row.onPresent({ (from, to) in
                    to.enableDeselection = false
                })
            }

            <<< PushRow<String>() { row in
                row.tag = User.JSON_MAJOR
                row.title = "Major"
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
                    self.logOut()
                })
        }
    }
    
    
    private func reloadProfile(){
        startWaitActivity()
        DataManager.sharedInstance.getProfile { (user, error) in
            self.endWaitactivity()
            if self.handleError(error) {
                return
            }
            self.form.setValues((user?.toJSON())!)
            self.tableView.reloadData()
        }
    }
    
    private func saveProfile(){
        startWaitActivity()
        DataManager.sharedInstance.updateProfile(profile: User(json: form.values())!) { (error) in
            self.endWaitactivity()
            if self.handleError(error) {
                return
            }
            self.view.makeToast("Saved successfully.")
        }
    }
    
    private func showAcknowledgements(){
        let viewController = AcknowListViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
