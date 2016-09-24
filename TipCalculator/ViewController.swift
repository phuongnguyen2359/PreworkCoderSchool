//
//  ViewController.swift
//  TipCalculator
//
//  Created by Nguyen The Phuong on 9/24/16.
//  Copyright © 2016 Nguyen The Phuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    let defaults = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var tipTitleLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var percentageTitleLabel: UILabel!
    var minimumPercentage : Double = 0
    var mediumPercentage : Double = 0
    var maximumPercentage : Double = 0
    @IBOutlet weak var onePersonTotal: UILabel!
    @IBOutlet weak var twoPersonTotal: UILabel!
    @IBOutlet weak var threePersonTotal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0)
        billField.delegate = self
        billField.text = ""
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        let currencySymbol = formatter.currencySymbol
        billField.placeholder = currencySymbol
        tipLabel.text = formatter.stringFromNumber(defaults.integerForKey("Tip"))
        totalLabel.text = formatter.stringFromNumber(defaults.integerForKey("Total"))
        onePersonTotal.text = formatter.stringFromNumber(defaults.integerForKey("First"))
        twoPersonTotal.text = formatter.stringFromNumber(defaults.integerForKey("Second"))
        threePersonTotal.text = formatter.stringFromNumber(defaults.integerForKey("Third"))
        billField.becomeFirstResponder()
        defaults.setObject("English", forKey: "Language")
        defaults.setObject("Dark", forKey: "Theme")
        if (defaults.integerForKey("Minimum") != 10 || defaults.integerForKey("Medium") != 15 || defaults.integerForKey("Maximum") != 20){
            //do nothing
        }
        else{
            self.defaults.setInteger(10, forKey: "Minimum")
            self.defaults.setInteger(15, forKey: "Medium")
            self.defaults.setInteger(20, forKey: "Maximum")
            self.defaults.synchronize()
        }
        self.settingsButton.title = "Settings"
    }
    override func viewWillAppear(animated: Bool) {
        billField.becomeFirstResponder()
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        let currencySymbol = formatter.currencySymbol
        billField.placeholder = (currencySymbol)
        //let tip = billAmount * tipPercentage
        //let total = billAmount + tip
        if (defaults.integerForKey("Bill") == 0){
            tipLabel.text = formatter.stringFromNumber(defaults.integerForKey("Tip"))
            totalLabel.text = formatter.stringFromNumber(defaults.integerForKey("Total"))
            onePersonTotal.text = formatter.stringFromNumber(defaults.integerForKey("First"))
            twoPersonTotal.text = formatter.stringFromNumber(defaults.integerForKey("Second"))
            threePersonTotal.text = formatter.stringFromNumber(defaults.integerForKey("Third"))
        }
        else{
            billField.text = String(defaults.integerForKey("Bill"))
            tipLabel.text = formatter.stringFromNumber(defaults.integerForKey("Tip"))
            totalLabel.text = formatter.stringFromNumber(defaults.integerForKey("Total"))
            onePersonTotal.text = formatter.stringFromNumber(defaults.integerForKey("First"))
            twoPersonTotal.text = formatter.stringFromNumber(defaults.integerForKey("Second"))
            threePersonTotal.text = formatter.stringFromNumber(defaults.integerForKey("Third"))
        }
        if (String(defaults.objectForKey("Language")!) == "Vietnamese"){
            percentageTitleLabel.text = "Phần trăm"
            totalTitleLabel.text = "Tổng"
            tipTitleLabel.text = "Tiền Tip +"
            self.title = "Tính tiền típ"
            self.settingsButton.title = "Cài Đặt"
        }
        else {
            percentageTitleLabel.text = "Percentage"
            totalTitleLabel.text = "Total"
            tipTitleLabel.text = "Tip +"
            self.title = "Tip Calculator"
            self.settingsButton.title = "Settings"
            
        }
        if (String(defaults.objectForKey("Theme")!) == "Not Dark"){
            UIView.animateWithDuration(3,
                                       delay: 0.0,
                                       options:
                [UIViewAnimationOptions.Repeat,.Autoreverse,.AllowUserInteraction],
                                       animations: {
                                        self.view.backgroundColor = UIColor(red: 226/255, green: 240/255, blue: 226/255, alpha: 1.0)
                                        self.view.backgroundColor = UIColor(red: 220/255, green: 255/255, blue: 0/255, alpha: 1.0)
                                        
                }, completion: nil)
            self.tipControl.tintColor = UIColor.orangeColor()
            self.percentageTitleLabel.textColor = UIColor.orangeColor()
        }
        else{
            
            
            self.view.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0)
            tipControl.tintColor = UIColor.blackColor()
            percentageTitleLabel.textColor = UIColor.blackColor()
            
            
        }
        minimumPercentage = Double(defaults.integerForKey("Minimum"))
        mediumPercentage = Double(defaults.integerForKey("Medium"))
        maximumPercentage = Double(defaults.integerForKey("Maximum"))
        
        tipControl.setTitle(String(defaults.integerForKey("Minimum")) + "%", forSegmentAtIndex: 0)
        tipControl.setTitle(String(defaults.integerForKey("Medium")) + "%", forSegmentAtIndex: 1)
        tipControl.setTitle(String(defaults.integerForKey("Maximum")) + "%", forSegmentAtIndex: 2)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onEditingChange(sender: AnyObject) {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        //let currencySymbol = formatter.currencySymbol
        var tipPercentages = [minimumPercentage/100,mediumPercentage/100,maximumPercentage/100]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        print(formatter.stringFromNumber(total))
        tipLabel.text = formatter.stringFromNumber(tip)!
        totalLabel.text = formatter.stringFromNumber(total)!
        //            totalLabel.text = String(format : "$ %0.0f",total)
        onePersonTotal.text = formatter.stringFromNumber(total/2)
        twoPersonTotal.text = formatter.stringFromNumber(total/3)
        threePersonTotal.text = formatter.stringFromNumber(total/4)
        defaults.setInteger(Int(billAmount), forKey: "Bill")
        defaults.setInteger(Int(tip), forKey: "Tip")
        defaults.setInteger(Int(total), forKey: "Total")
        defaults.setInteger(Int(total/2), forKey: "First")
        defaults.setInteger(Int(total/3), forKey: "Second")
        defaults.setInteger(Int(total/4), forKey: "Third")
        defaults.setInteger(2, forKey : "MainDidChanged")
        defaults.synchronize()
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return (textField.text?.characters.count ?? 0) + string.characters.count - range.length < 7
        
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

