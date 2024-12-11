//
//  SoundManager.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 27/06/2020.
//  Copyright (c) 2020 Syed Kashan. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import Swinject
import AVFoundation

typealias HSM = SoundManager

protocol ISoundManager: class {
    // do someting...
}

class SoundManager: ISoundManager {
     static let make = SoundManager()
     var player: AVAudioPlayer?
    
    enum SOUNDS {
        case tap, error, success
        func getValue() -> String {
            switch self {
            case .tap:
                return "Tap"
            case .error:
                return "Error"
            case .success:
                return "Success"
            }
        }
    }
    
    public func sound(_ type: SOUNDS) {
        playSound(type: type)
        UIDevice.vibrate()
    }
    public func vibrate() {
        UIDevice.vibrate()
    }
    private func playSound(type: SOUNDS) {
        guard let url = Bundle.main.url(forResource: "\(type.getValue())", withExtension: "m4a") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()
            

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
