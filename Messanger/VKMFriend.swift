//
//  VKMFriend.swift
//  Messanger
//
//  Created by Gregory House on 22.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class VKMFriend: NSObject
{
    var id: String
    var name: String
    var online: Int
    var avatarURL: String
    
    init(withID id: String, name: String, online: Int, avatarURL: String)
    {
        self.id = id
        self.name = name
        self.online = online
        self.avatarURL = avatarURL
        
        super.init()
    }
}
