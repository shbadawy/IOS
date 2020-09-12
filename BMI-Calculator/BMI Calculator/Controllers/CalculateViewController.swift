//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    var calculatorBrain = CalculatorBrain()
    
    @IBOutlet weak var heightLable: UILabel!
    @IBOutlet weak var weightLable: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    var BMI : Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        
        let sliderValue:Float = sender.value
        heightLable.text = String(format: "%.2f m", sliderValue)
        
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        
        let sliderValue:Int = Int (sender.value)
        weightLable.text = String (format: "%d Kg", sliderValue)
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        var height:Float = heightSlider.value
        let weight:Int = Int (weightSlider.value)
        
        if height == 0 { height = 0.0001}
        
        calculatorBrain.calculateBMI(weight: weight, height: height)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResult" {
            
            let destinationVC = segue.destination as! ResultViewController

            destinationVC.bmiValue = calculatorBrain.getBMI()
            destinationVC.color = calculatorBrain.getcolor()
            destinationVC.message = calculatorBrain.getmessage()
            
        }
    }
}

