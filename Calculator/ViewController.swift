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
        print("\(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            //someone sets the 'displayvalue' we set the display text'
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        switch operation {
            case "x": performOperation{$0 * $1};
            case "+": performOperation{$0 + $1};
            case "-": performOperation{$0 - $1};
            case "/": performOperation{$1 / $0};
            case "√": performOperation{sqrt($0)};
            default :
                break;
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter();
        }
        
    }
    @nonobjc
    func performOperation(operation: Double -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter();
        }
        
    }
    
}

