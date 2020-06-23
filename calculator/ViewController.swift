//
//  ViewController.swift
//  calculator
//
//  Created by Femi Abolaji on 23/05/2020.
//  Copyright © 2020 Femi Abolaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // buttons
    @IBOutlet weak var resultScreen: UILabel!
    var tempValue: String = "0"
    var listOfValues: [String] = []
    var op: String = ""
    var signedUnsigned = ""
    var override = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        render(tempValue)
    }
    
    private func render(_ value: String) -> Void {
        let parts = value.components(separatedBy: ".")
        
        resultScreen.text = parts.count > 1 && parts[1] == "0"
            ? parts[0]
            : value
    }
    
    private func isScreenValueZero() -> Bool {
        return tempValue == "0"
    }
    
    private func inputValue(value: String, override: Bool = false) -> Void {
        if !override {
            tempValue = isScreenValueZero() ? "\(value)" : "\(tempValue)\(value)"
            render(tempValue)
            return
        }
        render(value)
    }
    
    private func evaluateExpression(first: Double, second: Double, opSymbol: String) -> Double {
        var result: Double = 0
        
        switch opSymbol {
            case "+":
                result = first + second
            case "-":
                result = first - second
            case "*":
                result = first * second
            case "/":
                result = first / second
            case "%":
                result = first / 100.0
            case "+/-":
                // add negative sign to screen
                // keep a reference to our sign
                // save to the signed_unsigned variable
                // check if the variable (signed_unsigned) is plus if it is, change to minus - TOGGLE
                // check if the variable (signed_unsigned) is minus if it is, change to plus - TOGGLE
                // input number, check if the signed_unsigned var is negative
                // if it is negative then save the negative value of the insterted number into the array
                // delete sign from the var
            break
//                render("-")
            default:
                break
        }

        return result
    }
    
    @IBAction func resetButtonClick(_ sender: UIButton) {
        tempValue = "0"
        op = ""
        listOfValues = []
        render(tempValue)
        signedUnsigned = ""
    }
    
    @IBAction func operatorButtonClick(_ sender: UIButton) {
        listOfValues.append(tempValue)
        print(listOfValues)

//        if listOfValues.count == 2 {
//            let a = Double(listOfValues.remove(at: 0))!
//            let b = Double(listOfValues.remove(at: 0))!
//            print(a, b)
//
////            let result = String(evaluateExpression(first: a, second: b, opSymbol: op))
////            listOfValues.insert(result, at: 0)
////            inputValue(value: result, override: true)
//        }

        tempValue = "0"
        op = sender.titleLabel?.text ?? ""
    }
    
    @IBAction func onInputEntry(_ sender: UIButton) {
        var value = sender.titleLabel?.text ?? ""
        
        if value == "+/-" {
            signedUnsigned = signedUnsigned == "" || signedUnsigned == "+" ? "-" : "+"
            override = true
            print(signedUnsigned)
        } else {
            let isDecimalPresent = tempValue.firstIndex(of: ".") != nil
            if value == "." && isDecimalPresent {
                return
            }
            
            if signedUnsigned == "-" {
                value = "-\(value)"
            }
            inputValue(value: value, override: override)
            override = false
            print(value)
            signedUnsigned = ""
        }
    }
    
}

