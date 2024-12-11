//
//  ChatListTableViewCell.swift
//  HYDD-driver
//
//  Created by Macbook Pro on 07/04/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageFriend: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension ChatListTableViewCell: SetupCell {
    func configureCell<T>(object: T) {
        guard let chat = object as? ChatModel else {return}
        labelName.attributedText = "\(chat.userName)".styled(as: .gibsonRegular_16sp)
        imageFriend.makeRoundedImage()
        DispatchQueue.main.async {
            ImageManager.shared.setImage(url: chat.userImage, imageView: self.imageFriend)
        }
        labelMessage.attributedText = "\(chat.message)".styled(as: .gibsonRegular_14sp)
        
    }
    
}
