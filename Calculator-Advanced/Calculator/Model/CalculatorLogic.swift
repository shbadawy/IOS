//
//  CalculatorLogicViewController.swift
//  Calculator
//
//  Created by Shimaa Badawy on 10/27/20.
//  Copyright © 2020 London App Brewery. All rights reserved.
//

import Foundation

class CalculatorLogic {
    
    private var firstNumber:Double = 0.0
    private var total:Double = 0.0
    private var lastOp:String = ""
    
    var opIsSet:Bool = false
    var buttonTitle:String = ""
    var diplayValue:Double = 0
    var isInt:Bool = true
    
    func calculate() -> String {
        
        switch buttonTitle {
        case "AC":
            return clear()
        case "+/-":
            return String (diplayValue * -1)
        case "%":
            return String (diplayValue / 100.0)
        case "=":
            if lastOp != "" {
                firstNumber = total
                print(lastOp)
                switch lastOp {
                case "+":
                    total = total + diplayValue
                case "-":
                    total = total - diplayValue
                case "×":
                    total = total * diplayValue
                case "÷":
                    if diplayValue != 0{
                        total = total / diplayValue
                    }
                    else{
                        return ("0")
                    }
                default:
                    print("Done")
                }
                lastOp = ""
                opIsSet=false
                isInt=true
                
                
            }
            return String(total)
        default:
            isInt=true
            if !opIsSet {
                if lastOp != "" {
                    
                    if lastOp == "+" {
                        
                        total = total + firstNumber
                        firstNumber = diplayValue
                        
                    }else if lastOp == "-"{
                        
                        total = total - firstNumber
                        firstNumber = diplayValue
                        
                    }else if lastOp == "×"{
                        
                        total = total * firstNumber
                        firstNumber = diplayValue
                        
                    }else if lastOp == "÷"{
                        
                        if diplayValue != 0 {
                            total = total / firstNumber
                            firstNumber = diplayValue
                        }
                        
                    }
                    
                }else{
                    
                    total = diplayValue
                    firstNumber = diplayValue
                    
                }
                
                lastOp = buttonTitle
                opIsSet = true
                return lastOp
                
            }
//            else {
//
//                if buttonTitle != "="{
//                    lastOp = buttonTitle
//                    return (lastOp,isInt)
//
//                }
//
//            }
            
            
        }
        return ""
        
    }
    
    private func clear() -> String {
        
        lastOp = ""
        total = 0
        isInt = true
        opIsSet = false
        return "0"
        
    }
    
}
