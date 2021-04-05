//
//  ViewController.swift
//  8-ball
//
//  Created by Михаил Щербаков on 02/04/2021.
//

import UIKit

class ViewController: UIViewController {
    
    let ballArray = [#imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "3") , #imageLiteral(resourceName: "5")]
    
    @IBOutlet weak var Ball: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.becomeFirstResponder() // To get shake gesture
            }

            // We are willing to become first responder to get shake motion
            override var canBecomeFirstResponder: Bool {
                get {
                    return true
                }
            }

            // Enable detection of shake motion
            override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
                if motion == .motionShake {
        //            do {
        //                audioPlayer = try AVAudioPlayer(contentsOf: shake)
        //                        audioPlayer.play()
        //                   } catch {
        //                      // couldn't load file :(
        //                   }
                    let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
                    feedbackGenerator.impactOccurred()
                    DispatchQueue.global(qos: .background) .async { [self] in
                        for _ in 1...10{
                            DispatchQueue.main.sync {
                                self.Ball.image = self.ballArray.randomElement()
                            }
                            usleep(100000)
                        }
                    }
                }

        
    }

    
    
}

