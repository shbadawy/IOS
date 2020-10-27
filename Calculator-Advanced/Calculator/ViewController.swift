//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var firstNumber:Double = 0.0
    
    private var total:Double = 0.0
    private var lastOp:String = ""
    private var finishedTyping:Bool = true
    private var opIsSet:Bool = false
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        
        if let title = sender.currentTitle {
            
            if let displayText = displayLabel.text{
                
                if let number = Double(displayText){
                    
                    finishedTyping = true
                    
                    switch title {
                    case "AC":
                        clear()
                        break
                    case "+/-":
                        displayLabel.text = String(number * -1)
                        print("+/-")
                        break
                    case "%":
                        displayLabel.text = String(number / 100.0)
                        print("%")
                        break
                    case "=":
                        if lastOp != "" {
                            firstNumber = total
                            switch lastOp {
                            case "+":
                                total = total + number
                            case "-":
                                total = total - number
                            case "*":
                                total = total * number
                            case "/":
                                if number != 0{
                                total = total / number
                                }
                            default:
                                print("Done")
                            }
                            displayLabel.text = String(total)
                            lastOp = ""
                            opIsSet=false
                        }
                        break
                    default:
                        print("Getting ")
                        if !opIsSet {
                            if lastOp != "" {
                                
                                if lastOp == "+" {
                                    
                                    total = total + firstNumber
                                    firstNumber = number
                                    print("+++++")
                                    
                                }else if lastOp == "-"{
                                    
                                    total = total - firstNumber
                                    firstNumber = number
                                    
                                }else if lastOp == "x"{
                                    
                                    total = total * firstNumber
                                    firstNumber = number
                                    
                                }else if lastOp == "÷"{
                                    
                                    if number != 0 {
                                        total = total / firstNumber
                                        firstNumber = number
                                    }
                                    
                                }
                                
                            }else{
                                
                                total = number
                                firstNumber = number
                                print(total)
                                
                            }
                            
                            lastOp = title
                            displayLabel.text = lastOp
                            opIsSet = true
                            
                            break
                            
                        }
                        
                    }
                }else {
                    if title != "="{
                    lastOp = title
                    displayLabel.text = lastOp
                    print(opIsSet)
                    
                    }
                    
                }
                
            }
        }
        
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if let number = sender.currentTitle {
            if let lableText = displayLabel.text{
                if finishedTyping {
                    
                    displayLabel.text = number
                    finishedTyping = false
                    opIsSet = false
                    
                }else{
                    
                    if number == "." {
                        
                        let isInt = Double(lableText) == floor(Double(lableText)!)
                        
                        if !isInt {
                            return
                        }
                        
                    }
                        
                        displayLabel.text = lableText+number
                        
                    
                }
                
            }
        }
        
    }
    
    func clear( clearTotal:Bool = true)  {
        
        displayLabel.text = "0"
        lastOp = ""
        
        finishedTyping = true
        opIsSet = false
        
        total = 0
        
    }
    
}

