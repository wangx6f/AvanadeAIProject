//
//  SimplePickerTextField.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/16/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField

@IBDesignable
class SimplePickerTextField : SkyFloatingLabelTextField , UIPickerViewDataSource, UIPickerViewDelegate {
    
    private var options : [String]?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    func setOptions (_ options:[String]){
        self.options = options
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        self.inputView = pickerView
    
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (options?.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = options?[row]
    }
    
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {

        if action == #selector(cut(_:)) {
            return false
        }
        if action == #selector(paste(_:)) {
            return false
        }
        if action == #selector(delete(_:)) {
            return false
        }
        if action == #selector(replace(_:withText:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }   
}
