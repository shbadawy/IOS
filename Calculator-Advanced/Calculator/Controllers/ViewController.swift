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
    
    private var calcolator = CalculatorLogic()
    private var finishedTyping:Bool = true
    private var opIsSet:Bool = false
    
    var isInt:Bool = true
    
    private var displatText:String {
        
        get{
            
            guard let text = displayLabel.text else {fatalError("No valid display text")}
            return text
            
        }
        
    }
    private var diplayValue:Double {
        
        get{
            
            guard let number =  Double(displatText)  else {fatalError("Error getting double")}
            return number
            
        }
        
        set{
            
            displayLabel.text = String (newValue)
            
        }
        
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        finishedTyping = true
        
        if let buttonText = sender.currentTitle{
            calcolator.buttonTitle = buttonText
            calcolator.opIsSet = opIsSet
            calcolator.isInt = isInt
            if let value = Double(displatText){
                calcolator.diplayValue = value
            }
            
            displayLabel.text = calcolator.calculate()
            opIsSet = calcolator.opIsSet
            isInt = calcolator.isInt
            
        }
        
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if let number = sender.currentTitle {
            // If in operation mode
            if finishedTyping {
                
                displayLabel.text = number
                finishedTyping = false
                opIsSet = false
                
            }
            //If in input mode
            else{
                let lastChar = displatText.index(before: displatText.endIndex)
                
                if number == "." {
                    
                    if  displatText[lastChar] == "." || !isInt {return}
                    
                    if isInt {
                        
                        isInt = Double(displatText) == floor(Double(displatText)!)
                        if !isInt {return}
                        displayLabel.text = displatText+"."
                        isInt = false
                        
                    }
                    
                }else {
                    
                    displayLabel.text = displatText+number
                    
                }
                
            }
            
        }
        
        
        
    }
}

