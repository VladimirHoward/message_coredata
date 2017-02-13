//
//  ACConst.swift
//  Messenger
//
//  Created by MacAdmin on 22.01.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import Foundation

class ACConst
{
    class URLConst
    {
        static let kBaseURL = "https://api.vk.com/method/"

        class Scripts
        {
            static let kFriendsGet = "friends.get"
            static let kMethodMessage = "messages.getDialogs"
            static let kMethodUser = "users.get"
        }
        
        class Arguments
        {
            static let kCount : NSString = "count"
            static let kFields: NSString = "fields"
            static let kOrder: NSString = "order"
            static let kOffset: NSString = "offset"
            static let kAccessToken: NSString = "access_token"
            static let kUser : NSString = "user_ids"
        }

    }
    class UIConst
    {
        static let kLoginScreenIdentifier = "kLoginScreenIdentifier"
        static let kTabbarScreenIdentifier = "kTabbarScreenIdentifier"
        static let kLoginTabbarSegueIdentifier = "kLoginTabbarSegueIdentifier"
    }
}
