//
//  ViewController.swift
//  Swift Savings Visualizer
//
//  Created by Albert Saucedo on 10/25/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtYearlyIncome: UITextField!
    @IBOutlet weak var txtNumberOfYears: UITextField!

    @IBOutlet weak var sldPercent: UISlider!

    @IBOutlet weak var lblPercentSaved: UILabel!
    @IBOutlet weak var lblWeeklySaved: UILabel!
    @IBOutlet weak var lblMonthlySaved: UILabel!
    @IBOutlet weak var lblYearlySaved: UILabel!
    @IBOutlet weak var lblFutureSaved: UILabel!

    var percentVisual:Float = 0
    var yearlyIncome = ""
    var futureYears = ""
    var percentSavedDecimal:Float = 0
    var weeklySaved:Float = 0
    var monthlySaved:Float = 0
    var yearlySaved:Float = 0
    var futureSaved:Float = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultLabelSettings()
    }

    @IBAction func btnClear(sender: UIButton) {
        defaultLabelSettings()
    }

    @IBAction func btnCalculate(sender: UIButton) {
        calcUlatePercentageSaved()
    }

    @IBAction func sldPercent(sender: UISlider) {
        calcUlatePercentageSaved()
    }

    func calcUlatePercentageSaved() -> Bool{

        yearlyIncome = txtYearlyIncome.text
        futureYears = txtNumberOfYears.text
        percentSavedDecimal = sldPercent.value

        var fYearlyIncome = (yearlyIncome as NSString).floatValue
        var fFutureYears = (futureYears as NSString).floatValue

        percentVisual = percentSavedDecimal * 100
        weeklySaved = (fYearlyIncome / 52) * percentSavedDecimal
        monthlySaved = (fYearlyIncome / 12) * percentSavedDecimal
        yearlySaved = fYearlyIncome * percentSavedDecimal
        futureSaved = (fYearlyIncome * percentSavedDecimal) * fFutureYears

        var formatPercentSaved :NSString = NSString(format: "%0.0f", percentVisual)
        var formatWeeklySaved :NSString = NSString(format: "%0.0f", weeklySaved)
        var formatMonthlySaved :NSString = NSString(format: "%0.0f", monthlySaved)
        var formatYearlySaved :NSString = NSString(format: "%0.0f", yearlySaved)
        var formatFutureSaved :NSString = NSString(format: "%0.0f", futureSaved)

        lblPercentSaved.text = "If you save \(formatPercentSaved)% of your income"
        lblWeeklySaved.text = "$\(formatWeeklySaved)"
        lblMonthlySaved.text = "$\(formatMonthlySaved)"
        lblYearlySaved.text = "$\(formatYearlySaved)"
        lblFutureSaved.text = "$\(formatFutureSaved)"

        return true
    }

    func defaultLabelSettings(){
        txtYearlyIncome.text = ""
        txtNumberOfYears.text = ""

        percentSavedDecimal = sldPercent.value
        percentVisual = percentSavedDecimal * 100
        var formatPercentSaved :NSString = NSString(format: "%0.0f", percentVisual)

        lblPercentSaved.text = "If you save \(formatPercentSaved)% of your income"
        lblFutureSaved.text = "$0"
        lblMonthlySaved.text = "$0"
        lblWeeklySaved.text = "$0"
        lblYearlySaved.text = "$0"

    }

    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {

    var shouldChange = false

    if countElements(txtNumberOfYears.text) < 2 {
    shouldChange = true
    }

    return shouldChange
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        calcUlatePercentageSaved()
        txtYearlyIncome.resignFirstResponder()
        txtNumberOfYears.resignFirstResponder()
    }
}