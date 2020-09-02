//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let time: [String:Int] = ["Soft":5,"Medium":7,"Hard":12]
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        var total:Int = time[sender.currentTitle!]! * 60
        
        while total != 0 {
            print(total)
            sleep(1)
            total-=1
        }
        
//        print (sender.currentTitle!)
//        print(time[sender.currentTitle!])
        
    }
    
    
}
