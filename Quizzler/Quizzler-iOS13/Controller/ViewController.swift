//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLable: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var scoreLable: UILabel!
    
    @IBOutlet weak var tryAgain: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    var quizBrain = QuizBrain()
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle!
        if quizBrain.checkAnswer(userAnswer){
        
            sender.backgroundColor=UIColor.green
            scoreLable.text="Score = \(quizBrain.getScore())"
            
        }else{
            
            sender.backgroundColor=UIColor.red
            
        }
        
         Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        questionLable.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgress()
        
    }

    @objc func updateUI()  {
        
        let finished=quizBrain.updateQuestion()
        
        if finished {
            
            trueButton.isHidden=true
            falseButton.isHidden=true
            tryAgain.isHidden=false
//            questionLable.text=quizBrain.printFinalResulr()
            
        }else{
            
            trueButton.backgroundColor=UIColor.clear
            falseButton.backgroundColor=UIColor.clear
            questionLable.text=quizBrain.getQuestionText()
            
        }
        
        progressBar.progress=quizBrain.getProgress()
        
        
    }
    @IBAction func reset(_ sender: UIButton) {
        
        trueButton.isHidden=false
        falseButton.isHidden=false
        tryAgain.isHidden=true
        trueButton.backgroundColor=UIColor.clear
        falseButton.backgroundColor=UIColor.clear
        
        quizBrain.reset()
        
        progressBar.progress=quizBrain.getProgress()
        questionLable.text = quizBrain.getQuestionText()
                
    }
    
}

