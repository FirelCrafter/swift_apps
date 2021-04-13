//
//  ViewController.swift
//  Let's Rock
//
//  Created by Михаил Щербаков on 09/04/2021.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    var player: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func ButtonTapped(_ sender: UIButton) {
        playSound(soundName: sender.currentTitle!)
//        GSAudio().playSound(soundFileName: sender.currentTitle!)
    }
    
    func playSound(soundName: String) {
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else {return}
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            
            guard  let player = player else {return}
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    class GSAudio: NSObject, AVAudioPlayerDelegate {

        static let sharedInstance = GSAudio()

        public override init() { }

        var players: [URL: AVAudioPlayer] = [:]
        var duplicatePlayers: [AVAudioPlayer] = []

        func playSound(soundFileName: String) {

            guard let bundle = Bundle.main.path(forResource: soundFileName, ofType: "wav") else { return }
            let soundFileNameURL = URL(fileURLWithPath: bundle)

            if let player = players[soundFileNameURL] { //player for sound has been found

                if !player.isPlaying { //player is not in use, so use that one
                    player.prepareToPlay()
                    player.play()
                } else { // player is in use, create a new, duplicate, player and use that instead

                    do {
                        let duplicatePlayer = try AVAudioPlayer(contentsOf: soundFileNameURL)

                        duplicatePlayer.delegate = self
                        //assign delegate for duplicatePlayer so delegate can remove the duplicate once it's stopped playing

                        duplicatePlayers.append(duplicatePlayer)
                        //add duplicate to array so it doesn't get removed from memory before finishing

                        duplicatePlayer.prepareToPlay()
                        duplicatePlayer.play()
                    } catch let error {
                        print(error.localizedDescription)
                    }

                }
            } else { //player has not been found, create a new player with the URL if possible
                do {
                    let player = try AVAudioPlayer(contentsOf: soundFileNameURL)
                    players[soundFileNameURL] = player
                    player.prepareToPlay()
                    player.play()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }


        func playSounds(soundFileNames: [String]) {
            for soundFileName in soundFileNames {
                playSound(soundFileName: soundFileName)
            }
        }

        func playSounds(soundFileNames: String...) {
            for soundFileName in soundFileNames {
                playSound(soundFileName: soundFileName)
            }
        }

        func playSounds(soundFileNames: [String], withDelay: Double) { //withDelay is in seconds
            for (index, soundFileName) in soundFileNames.enumerated() {
                let delay = withDelay * Double(index)
                let _ = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(playSoundNotification(_:)), userInfo: ["fileName": soundFileName], repeats: false)
            }
        }

        @objc func playSoundNotification(_ notification: NSNotification) {
            if let soundFileName = notification.userInfo?["fileName"] as? String {
                playSound(soundFileName: soundFileName)
            }
        }

        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            if let index = duplicatePlayers.firstIndex(of: player) {
                duplicatePlayers.remove(at: index)
            }
        }

    }
    
}

