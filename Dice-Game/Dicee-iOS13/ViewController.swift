//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    // Linking objects from the designer
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImagetwo: UIImageView!
    
    var leftDiceNumber = 1
    var rightDiceNumber = 5
    var array = [ #imageLiteral(resourceName: "DiceOne") , #imageLiteral(resourceName: "DiceTwo") , #imageLiteral(resourceName: "DiceThree") , #imageLiteral(resourceName: "DiceFour") , #imageLiteral(resourceName: "DiceFive") , #imageLiteral(resourceName: "DiceSix") ]
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        diceImageView1.image = array[leftDiceNumber]
        diceImagetwo.image = array[rightDiceNumber]
        
    }

    @IBAction func rollButtonPressed(_ sender: Any) {
        
        
        leftDiceNumber = leftDiceNumber+1
        rightDiceNumber = rightDiceNumber-1
        diceImageView1.image = array[leftDiceNumber]
        diceImagetwo.image = array[rightDiceNumber]
        
        
    }
    
}

