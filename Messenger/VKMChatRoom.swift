//
//  VKMChatRoom.swift
//  Messenger
//
//  Created by Admin on 04.02.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import Foundation
import CoreData

class VKMChatRoomCoreData : NSManagedObject
{
    @NSManaged var id : Int64
    @NSManaged var senderUserID : Int64
    @NSManaged var title : String
    @NSManaged var unread : Int64
    @NSManaged var out: Int64
    @NSManaged var body: String
    @NSManaged var userIDs: String
    @NSManaged var createdAt: Int64
}
