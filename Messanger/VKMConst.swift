//
//  VKMConst.swift
//  Messanger
//
//  Created by Gregory House on 22.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class ACConts
{
    class UIConst
    {
        static let kLoginScreenIdentifier = "kLoginScreenIdentifier"
        static let kTabbarScreenIdentifier = "kTabbarScreenIdentifier"
        static let kLoginTabbarSegueIdentifier = "kLoginTabbarSegueIdentifier"
    }
    
    class URLConst
    {
        static let kBaseURL = "https://api.vk.com/method/"
        
        class Scripts
        {
            static let kFriendsGet = "friends.get"
        }
        
        class Arguments
        {
            static let kCount : NSString = "count"
            static let kFields: NSString = "fields"
            static let kOrder: NSString = "order"
            static let kOffset: NSString = "offset"
            static let kAccessToken: NSString = "access_token"
        }

        
    }
}
