//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Kim on 06/03/16.
//  Copyright © 2016 Kim. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    //Op stack contains 2 kinds of operation and operands.
    private enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    //stack to keep track of entire 'sum' the user filled in.
    private var opStack = [Op]()
    
    //dictionary for the different kinds of operation
    private var knownOps = Dictionary<String, Op>()
    
    
    init() {
        knownOps["x"] = Op.BinaryOperation("x", *)
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["-"] = Op.BinaryOperation("-"){$1 - $0}
        knownOps["/"] = Op.BinaryOperation("/"){$1 / $0}
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
    }
    
    
    //two public functions to let the viewcontroller enter operands and perform operations.
    func pushOperand(operand: Double) {
        opStack.append(Op.Operand(operand))
    }
    func performOperation(symbol: String) {
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
        
    }
    
    //takes all the ops (opStack) and returns the results and the remaining sum.
    //to be called recursively until the sum is completely solved.
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]){
        
        
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                    if let operand1 = op1Evaluation.result {
                        let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                        if let operand2 = op2Evaluation.result {
                            return (operation(operand1, operand2), op2Evaluation.remainingOps)
                        }
                    }
            }
        }
        return (nil, ops);
        
    }
    
    func evaluate() -> Double? {
        let (result, _) = evaluate(opStack)
        return result
    }
    
}