//
//  VKMDialogChat.swift
//  Messanger
//
//  Created by Gregory House on 29.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class VKMDialogChat: VKMDialog
{
    var mId: Int64
    var uId: Int64
    var chatId: Int64
    var chatMembers: [String]
    var title: String
    var body: String
    var out: Int64
    
    init(WithMessegeId mId: Int64, uId: Int64, chatMembers: [String], title: String, body: String, out: Int64, type: Int, chatId: Int64)
    {
        self.mId = mId
        self.uId = uId
        self.chatId = chatId
        self.chatMembers = chatMembers
        self.title = title
        self.body = body
        self.out = out
        
        super.init(WithType: type)
    }
}
