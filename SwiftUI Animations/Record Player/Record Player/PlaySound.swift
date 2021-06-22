//
//  PlaySound.swift
//  Record Player
//
//  Created by Михаил Щербаков on 22/06/2021.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Couldn't find sound file")
        }
    }
}
