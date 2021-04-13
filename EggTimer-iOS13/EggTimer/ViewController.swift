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
    
    @IBOutlet weak var titleLabel: UILabel!
    
//    let softTime = 5
//    let mediumTime = 7
//    let hardTime = 12
    
    let eggTimes : [String : Int] = ["Soft": 3, "Medium": 4, "Hard": 7]
    
//    var secondsRemaining = 60
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
//        if hardness == "Soft"{
//            print(softTime)
//        } else if hardness == "Medium" {
//            print(mediumTime)
//        } else if hardness == "Hard" {
//            print(hardTime)
//        } else {
//            print("Error")
//        }
       
//        switch hardness {
//        case "Soft":
//            print(eggTimes["Soft"]!)
//        case "Medium":
//            print(eggTimes["Medium"]!)
//        case "Hard":
//            print(eggTimes["Hard"]!)
//        default:
//            print("Error")
//        }
        
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
       
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
        }
    }
    

}
