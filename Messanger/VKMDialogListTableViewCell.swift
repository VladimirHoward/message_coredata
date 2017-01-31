//
//  VKMDialogListTableViewCell.swift
//  Messanger
//
//  Created by Gregory House on 28.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import SDWebImage

class VKMDialogListTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var userPhotoView: UIImageView!
    @IBOutlet weak var dialogTitle: UILabel!
    @IBOutlet weak var dialogBody: UILabel!
    
    func configureSelf (withDataModel model: VKMDialog)
    {
        
        if model.type == 0
        {
            let modelForTwo = model as! VKMDialogForTwo
            dialogTitle.text = "беседа с \(modelForTwo.uId)"
            dialogBody.text = modelForTwo.body
        }
        else
        {
            if model.type == 1
            {
                let modelChat = model as! VKMDialogChat
                dialogTitle.text = modelChat.title
                dialogBody.text = modelChat.body
            }
            else
            {
                dialogBody.text = "ошибка типа сообщения"
            }
        }
    }
}
