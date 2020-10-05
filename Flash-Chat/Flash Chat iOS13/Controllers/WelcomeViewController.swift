//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadText()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    
    func loadText()  {
        
        let text:String = K.titleLable
        titleLabel.text = ""
        var charIndex = 0.0
        
        for char in text {
            
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex , repeats: false){ (timer) in
                
                self.titleLabel.text?.append(char)
                
            }
            charIndex+=1
        }
        
    }
    

}
