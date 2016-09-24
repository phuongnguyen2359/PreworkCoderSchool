//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Nguyen Duc Gia Bao on 9/24/16.
//  Copyright © 2016 Nguyen The Phuong. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    @IBOutlet weak var languagePicker: UIPickerView!
    let defaults = NSUserDefaults.standardUserDefaults()
    var languages = ["English","Vietnamese"]
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var maximumTipLabel: UILabel!
    @IBOutlet weak var mediumTipLabel: UILabel!
    @IBOutlet weak var minimumTipLabel: UILabel!
    @IBOutlet weak var defaultTipPercentageLabel: UILabel!
    @IBOutlet weak var changeThemeButton: UISwitch!
    @IBOutlet weak var themelabelLabel: UILabel!
    @IBOutlet weak var minimumTipTextField: UITextField!
    @IBOutlet weak var mediumTipTextField: UITextField!
    @IBOutlet weak var maximumTipTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        languagePicker.delegate = self
        minimumTipTextField.delegate = self
        mediumTipTextField.delegate = self
        maximumTipTextField.delegate = self
        self.view.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0)
        // Do any additional setup after loading the view, typically from a nib.
        //        var limitFirst : Bool
        //        var limitSecond : Bool
        //        var limitThird : Bool
        //        limitWord(minimumTipTextField,
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SettingsViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SettingsViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
    }
    override func viewWillAppear(animated: Bool) {
        if (String(defaults.objectForKey("Language")!) == "Vietnamese"){
            languagePicker.selectRow(1, inComponent: 0, animated: true)
            self.title = "Cài Đặt"
            languageLabel.text = "    Ngôn Ngữ"
            themeLabel.text = "    Bóng Tối"
            themelabelLabel.text = "    Chủ Đề"
            defaultTipPercentageLabel.text = "     % Típ Mặc Định"
            minimumTipLabel.text = "    Nhỏ Nhất"
            mediumTipLabel.text =  "    Trung Bình"
            maximumTipLabel.text = "    Lớn Nhất"
        }
        else {
            languagePicker.selectRow(0, inComponent: 0, animated: true)
        }
        minimumTipTextField.text = String(defaults.integerForKey("Minimum"))
        mediumTipTextField.text = String(defaults.integerForKey("Medium"))
        maximumTipTextField.text = String(defaults.integerForKey("Maximum"))
        changeUITheme()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
        
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let language : String = languages[row]
        defaults.setObject(language, forKey : "Language")
        defaults.synchronize()
        if (String(defaults.objectForKey("Language")!) == "Vietnamese" || String(defaults.objectForKey("Language")!) == "Tiếng Việt" ){
            self.title = "Cài Đặt"
            languageLabel.text = "    Ngôn Ngữ"
            themeLabel.text = "    Bóng Tối"
            themelabelLabel.text = "    Chủ Đề"
            defaultTipPercentageLabel.text = "    % Típ Mặc Định"
            minimumTipLabel.text = "    Nhỏ Nhất"
            mediumTipLabel.text = "    Trung Bình"
            maximumTipLabel.text = "    Lớn Nhất"
            //print(defaults.objectForKey("Language")!)
        }
        else {
            self.title = "Settings"
            languageLabel.text = "    Language"
            themeLabel.text = "    Dark"
            themelabelLabel.text = "    Theme"
            defaultTipPercentageLabel.text = "    Default Tip Percentage"
            minimumTipLabel.text = "    Minimum"
            mediumTipLabel.text = "    Medium"
            maximumTipLabel.text = "    Maximum"
            //print(defaults.objectForKey("Language")!)
        }
        
        //print(languages)
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        if minimumTipTextField.text != "" {
            self.defaults.setInteger(Int(self.minimumTipTextField.text!)!, forKey: "Minimum")
        }
        else{
            defaults.setInteger(0, forKey: "Minimum")
            //minimumTipTextField.text = "0"
        }
        if mediumTipTextField.text != ""{
            self.defaults.setInteger(Int(self.mediumTipTextField.text!)!, forKey: "Medium")
        }
        else {
            self.defaults.setInteger(0, forKey: "Medium")
            //mediumTipTextField.text = "0"
        }
        if maximumTipTextField.text != ""{
            self.defaults.setInteger(Int(self.maximumTipTextField.text!)!, forKey: "Maximum")
        }
        else {
            self.defaults.setInteger(0, forKey: "Maximum")
            //maximumTipTextField.text = "0"
        }
        if (changeThemeButton.on){
            defaults.setObject("Dark", forKey: "Theme")
        }
        else {
            defaults.setObject("Not Dark", forKey: "Theme")
        }
        defaults.synchronize()
        changeUITheme()
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return (textField.text?.characters.count ?? 0) + string.characters.count - range.length < 3
        
    }
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -80
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    func changeUITheme() ->(){
        if (String(defaults.objectForKey("Theme")!) == "Not Dark"){
            //            self.view.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0)
            changeThemeButton.on = false
            //            languageLabel.textColor = UIColor.blackColor()
            //            themelabelLabel.textColor = UIColor.blackColor()
            //            languagePicker.backgroundColor = UIColor.whiteColor()
            //            themeLabel.backgroundColor = UIColor.whiteColor()
            //            themeLabel.textColor = UIColor.blackColor()
            //            defaultTipPercentageLabel.textColor = UIColor.blackColor()
            //            minimumTipLabel.textColor = UIColor.blackColor()
            //            mediumTipLabel.textColor = UIColor.blackColor()
            //            maximumTipLabel.textColor = UIColor.blackColor()
            //            minimumTipLabel.backgroundColor = UIColor.whiteColor()
            //            mediumTipLabel.backgroundColor = UIColor.whiteColor()
            //            maximumTipLabel.backgroundColor = UIColor.whiteColor()
            
        }
        else{
            //            self.view.backgroundColor = UIColor(red: 177/255, green: 255/255, blue: 255/255, alpha: 1.0)
            changeThemeButton.on = true
            //            languageLabel.textColor = UIColor.redColor()
            //            themelabelLabel.textColor = UIColor.redColor()
            //            themeLabel.textColor = UIColor.redColor()
            //            defaultTipPercentageLabel.textColor = UIColor.redColor()
            //            minimumTipLabel.textColor = UIColor.redColor()
            //            mediumTipLabel.textColor = UIColor.redColor()
            //            maximumTipLabel.textColor = UIColor.redColor()
            //            languagePicker.backgroundColor = UIColor(red: 177/255, green: 255/255, blue: 177/255, alpha: 1.0)
            //            themeLabel.backgroundColor = UIColor(red: 177/255, green: 255/255, blue: 177/255, alpha: 1.0)
            //            minimumTipLabel.backgroundColor = UIColor(red: 177/255, green: 255/255, blue: 177/255, alpha: 1.0)
            //            mediumTipLabel.backgroundColor = UIColor(red: 177/255, green: 255/255, blue: 177/255, alpha: 1.0)
            //            maximumTipLabel.backgroundColor = UIColor(red: 177/255, green: 255/255, blue: 177/255, alpha: 1.0)
        }
        
    }
    
    
    
}
