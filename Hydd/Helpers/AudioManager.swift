//
//  AudioManager.swift
//  HYYD ClientSide
//
//  Created by Saad on 2/23/21.
//  Copyright © 2021 Syed Kashan. All rights reserved.
//

import Foundation
import AVFoundation

class AudioManager {
    static let sharedInstance = AudioManager()
    var audioPlayer: AVAudioPlayer?
    var audioIndex = -1

    func play(_ url: URL, delegate: Any) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                //            try AVAudioSession.sharedInstance().setCategory(.playAndRecord)
                //            try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
                
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                let data = try Data(contentsOf: url)
                self.audioPlayer = try AVAudioPlayer(data: data, fileTypeHint: AVFileType.mp3.rawValue)
                self.audioPlayer?.delegate = delegate as? AVAudioPlayerDelegate
                self.audioPlayer?.prepareToPlay()
                self.audioPlayer?.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
