//
//  VKMUserFabric.swift
//  Messenger
//
//  Created by Gregory House on 05.02.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import Foundation
import CoreData

class VKMUserFabric
{
    class func createOrUpdateMessage (withUserId id: Int64, avatarURL: String, name: String, context: NSManagedObjectContext) -> VKMUser
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "VKMUser")
        let predicate = NSPredicate(format: "id=%lld", id)
        fetchRequest.predicate = predicate
        
        let fetchResults = try? context.fetch(fetchRequest) as! [VKMUser]
        
        if (fetchResults!.count != 0)
        {
            let user = fetchResults![0]
            
            user.avatarURL = avatarURL
            user.name = name
            
            return user
        }
        else
        {
            let user = NSEntityDescription.insertNewObject(forEntityName: "VKMUser", into: context) as! VKMUser
            
            user.id = id
            user.name = name
            user.avatarURL = avatarURL
            
            return user
        }

    }
    
    class func checkUser (withID id: Int64, context: NSManagedObjectContext) -> Bool
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "VKMUser")
        let predicate = NSPredicate(format: "id=%lld", id)
        fetchRequest.predicate = predicate
        
        let fetchResults = try? context.fetch(fetchRequest) as! [VKMUser]
        
        if (fetchResults!.count != 0)
        {
            let user = fetchResults![0]
            
            if ( user.name != "" )
            {
                return true
            }
            else
            {
                return false
            }
        }
        else
        {
            return false
        }
    }
    
    class func getUserFromCoreData (withId id: String, context: NSManagedObjectContext) -> VKMUser
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "VKMUser")
        let predicate = NSPredicate(format: "id=%@", id)
        fetchRequest.predicate = predicate
        
        let fetchResults = try? context.fetch(fetchRequest) as! [VKMUser]
        
        if (fetchResults!.count != 0)
        {
         
            return fetchResults![0]
            
        }
        else
        {
           return VKMUser ()
        }

    }
}





