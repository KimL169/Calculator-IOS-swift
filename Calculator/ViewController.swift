//
//  ViewController.swift
//  Calculator
//
//  Created by Kim on 01/03/16.
//  Copyright © 2016 Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //implicitly unwrapped optional.
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false;

    @IBAction func appendDigit(sender: UIButton) {
        
        let digit:String = sender.currentTitle!;
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true;
        }
        // String?  means the type is optional and the optional can be set to String
        // it is not a string that can be nil. nil means an optional that has not been set.
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(displayValue)")
    }
    
    var displayValue: Double {
        get {
            NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            //someone sets the 'displayvalue' we set the display text'
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

