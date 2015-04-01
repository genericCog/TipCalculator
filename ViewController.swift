//
//  ViewController.swift
//  TipCalculator
//
//  Created by Adam Cherochak on 4/1/15.
//  Copyright (c) 2015 Adam Cherochak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Interface Builder (optional = !)sub view properties
    @IBOutlet var totalTextField : UITextField!
    @IBOutlet var taxPctSlider : UISlider!
    @IBOutlet var taxPctLabel : UILabel!
    @IBOutlet var resultsTextView : UITextView!
    
    // declare callbacks for actions from views
    @IBAction func calculateTapped(sender : AnyObject) {
        // convert string to double
        tipCalc.total = Double((totalTextField.text as NSString).doubleValue)
        // call returnPossibleTips method on tipCalc Model, return dictionary of tip %'s
        let possibleTips = tipCalc.returnPossibleTips()
        var results = ""
        // enumerate through key/value pairs of dictionary
        var keys = Array(possibleTips.keys)
        sort(&keys)
        for tipPct in keys {
            let tipValue = possibleTips[tipPct]!
            let prettyTipValue = String(format:"%.2f", tipValue)
            results += "\(tipPct)%: \(prettyTipValue)\n"
        }
        // set results to the string being built
        resultsTextView.text = results
    }
    @IBAction func taxPercentageChanged(sender : AnyObject) {
        // reverse multiply by 100 behavior
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }
    @IBAction func viewTapped(sender : AnyObject) {
        // call resignFirstResponder when view is tapped (dismiss the keyboard)
        totalTextField.resignFirstResponder()
    }
    
    // connect view controller to model
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    
    func refreshUI() {
        // explicitly convert Double to String
        totalTextField.text = String(format: "%0.2f", tipCalc.total)
        // display tax percent as integer, cast from Float
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        // string interpolation to update label
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        // clear results until calc btn tapped
        resultsTextView.text = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

