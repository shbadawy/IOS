//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    let time: [String:Int] = ["Soft":5,"Medium":7,"Hard":12]
    var timer=Timer()
    var totalTime:Int=0
    var secondsPassed:Int = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        totalTime = time[sender.currentTitle!]! * 60
        
        timer=Timer.scheduledTimer(timeInterval: 1.0, target:self ,selector: #selector(updateTimer), userInfo:nil,repeats: true)

        
    }
    @objc func updateTimer (){
        
        if secondsPassed < totalTime{
            
            let percentageProgress = Float (secondsPassed)/Float(totalTime)
            progressBar.progress = percentageProgress
            
            secondsPassed+=1
            
        }else {
            
            timer.invalidate()
            print ("Done!")
            
        }
        
    }
    
    
    
}
