//
//  VKMMultichatFabric.swift
//  Messenger
//
//  Created by Gregory House on 05.02.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import Foundation
import CoreData

class VKMMultichatFabric
{
    class func createOrUpdateMessage (withId id: Int64, senderUserID: Int64, title: String, unread: Int64, out: Int64, body: String, multichatPicURL: String, userIDs: String, createdAt: Int64, context: NSManagedObjectContext) -> VKMMultichat
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "VKMChatRoomCoreData")
        let predicate = NSPredicate(format: "id=%lld", id)
        fetchRequest.predicate = predicate
        
        let fetchResults = try? context.fetch(fetchRequest) as! [VKMMultichat]
        
        if (fetchResults!.count != 0)
        {
            let message = fetchResults![0]
            message.title = title
            message.unread = unread
            message.out = out
            message.body = body
            message.multichatPicURL = multichatPicURL
            message.userIDs = userIDs
            message.createdAt = createdAt
            
            return message
        }
        else
        {
            let message = NSEntityDescription.insertNewObject(forEntityName: "VKMMultichat", into: context) as! VKMMultichat
            message.id = id
            message.senderUserID = senderUserID
            message.title = title
            message.unread = unread
            message.out = out
            message.body = body
            message.multichatPicURL = multichatPicURL
            message.userIDs = userIDs
            message.createdAt = createdAt


            return message
        }
    }
}
