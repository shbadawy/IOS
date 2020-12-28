//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let swifter = Swifter(consumerKey: K.key, consumerSecret: K.secret)
    let classifier = SentimeentClassifier()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func predictPressed(_ sender: Any) {
        
        var results = [SentimeentClassifierInput]()
        
        if let text = textField.text{
            
            swifter.searchTweet(using: text, lang: "en", count: 100 , tweetMode: .extended) { (result, metaData) in
                let tweets = JSON(result)
                for i in 0..<100{
                    if let tweet = tweets[i]["full_text"].string{
                        print(tweet)
                        let input = SentimeentClassifierInput(text: tweet)
                        results.append(input)
                        
                    }
                    
                }
                
                self.predect(with: results)
                
            } failure: { (error) in
                print(error)
            }
            
            
        }
        
    }
    
    func predect(with results: [SentimeentClassifierInput])  {
        
        let predictions = try! self.classifier.predictions(inputs: results)
        var score = 0
        
        for pred in predictions{
            
            let predText = pred.label
            
            if predText == "Pos"{score += 1}
            else if predText == "Neg" {score -= 1}
            
        }
        
        updateUI(with: score)
        
    }
    
    func updateUI(with score : Int)  {
        
        if score > 20 {sentimentLabel.text = "😍"}
        else if score > 10 {sentimentLabel.text = "😄"}
        else if score > 0 {sentimentLabel.text = "🙂"}
        else if score == 0 {sentimentLabel.text = "😕"}
        else if score > -10 {sentimentLabel.text = "🙁"}
        else if score > -20 {sentimentLabel.text = "😡"}
        else  {sentimentLabel.text = "🤮"}
        
    }
    
    
    
}

