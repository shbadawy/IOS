//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Mac on 9/12/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    var bmi : BMI?
    
    func getBMI() -> String {return String(format: "%.1f", self.bmi?.value ?? 0.0 )}
    func getmessage() -> String {return  self.bmi?.message ?? "" }
    func getcolor() -> UIColor {return  self.bmi?.color ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) }
    
    mutating func calculateBMI(weight : Int , height : Float){
        
        let bmiValue : Float = Float (weight) / pow(height, 2)
        let message : String
        let color : UIColor
        
        if bmiValue < 18.5 {message = "Eat more pies";color=#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)}
        else if bmiValue < 24.9 {message = "Normal weight";color=#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)}
        else {message = "Eat less pies";color=#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)}
        
        bmi = BMI(value: bmiValue, message: message, color: color)
        
    }
    
}
