//
//  ReceiverVoiceTableViewCell.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 24/06/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit
import AVFoundation

class ReceiverVoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var playButtonIcon: UIImageView!
    
    var chatMessage: ChatModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleInterruption),
                                               name: NSNotification.Name(rawValue: "audioInterruption"),
                                               object: nil)
    }
    
    private func playAudio() {
        self.playButtonIcon.image = UIImage(named: "pause.circle.fill")
        if let audioUrl = self.chatMessage?.audioURL, let url = URL(string: audioUrl) {
            AudioManager.sharedInstance.play(url, delegate: self)
            AudioManager.sharedInstance.audioIndex = self.tag
        }
    }
    
    @IBAction func actionPlay(_ sender: Any) {
        if let isPlaying = AudioManager.sharedInstance.audioPlayer?.isPlaying, isPlaying {
            if AudioManager.sharedInstance.audioIndex == self.tag {
                AudioManager.sharedInstance.audioPlayer?.pause()
                playButtonIcon.image = UIImage(named: "icon_play")
            } else {
                AudioManager.sharedInstance.audioPlayer?.stop()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "audioInterruption"), object: self)
                playAudio()
            }
        } else {
            playAudio()
        }
    }
}

extension ReceiverVoiceTableViewCell: SetupCell {
    func configureCell<T>(object: T) {
        guard let data = object as? ChatModel else {return}
        chatMessage = data
    }
}

extension ReceiverVoiceTableViewCell: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            playButtonIcon.image = UIImage(named: "icon_play")
        }
    }
    
    @objc func handleInterruption() {
        playButtonIcon.image = UIImage(named: "icon_play")
    }
}
