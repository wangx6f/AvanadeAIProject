//
//  SettingsForm.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/11/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import Eureka
import Gloss
import AcknowList
import Toast_Swift

class SettingsFormController: FormViewController, UINavigationControllerDelegate {

    private let aboutSegueIdentifier = "goToAbout"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        reloadProfile()
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        configForm()
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
        
        form.removeAll()
        
        if DataManager.sharedInstance.loginStatus() {
            form +++ Section("Profile")
                <<< NameRow() { row in
                    row.tag = User.JSON_FIRST_NAME
                    row.title = "First Name"
                }
                <<< NameRow() { row in
                    row.tag = User.JSON_LAST_NAME
                    row.title = "Last Name"
                }
                <<< NameRow() { row in
                    row.tag = User.JSON_TITLE
                    row.title = "Title"
                }
                <<< NameRow() { row in
                    row.tag = User.JSON_COMPANY
                    row.title = "Company"
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
                    DataManager.sharedInstance.clearSearchHistory()
                    self.view.makeToast("Done!")
                    
                })
            }
            
            form +++ ButtonRow() { row in
                row.title = "Log Out"
                row.onCellSelection({ _,_ in
                    self.logOut()
                    self.configForm()
                })
            }
        }
        else {
            form
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
                    DataManager.sharedInstance.clearSearchHistory()
                    self.view.makeToast("Done!")
                    
                })
            }
            
            form +++ ButtonRow() { row in
                row.title = "Log In"
                row.onCellSelection({ _,_ in
                    self.performSegue(withIdentifier: "goToLogin", sender: self)
                })
            }
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
        DataManager.sharedInstance.updateProfile(profile: User(json: form.values() as JSON)!) { (error) in
            self.endWaitactivity()
            if self.handleError(error) {
                return
            }
            self.view.makeToast("Saved successfully.")
        }
    }
    
    private func showAcknowledgements(){
        let viewController = AcknowListViewController(fileNamed: "Pods-AvanadeAIProject-acknowledgements")
        navigationController?.pushViewController(viewController, animated: true)
    }
}
