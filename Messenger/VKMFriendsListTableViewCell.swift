//
//  VKMFriendsListTableViewCell.swift
//  Messenger
//
//  Created by MacAdmin on 22.01.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import UIKit
import SDWebImage

class VKMFriendsListTableViewCell: UITableViewCell
{
    @IBOutlet weak var avatarIV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var onlineDot: UIView!
    
    func configureSelf ( withDataModel model : VKMFriend )
    {
        avatarIV.sd_setImage(with: URL(string: model.avatarURL)!)
        nameLabel.text = model.name
        
        if model.online == 1
        {
            onlineDot.isHidden = false
        }
        else
        {
            onlineDot.isHidden = true
        }
    }
    
}
