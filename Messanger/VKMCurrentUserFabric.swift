//
//  VKMCurrentUserFabric.swift
//  Messanger
//
//  Created by Admin on 15.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import CoreData

/**
 фабрика - получение и обновление моделей
 */

class VKMCurrentUserFabric
{
    //MARK: - create or update текущего пользователя
    class func createOrUpdateModel (withID id: Int64, access_token: String, context: NSManagedObjectContext) -> VKMCurrentUser
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "VKMCurrentUser")
        let predicate = NSPredicate(format: "id=%lld", id)
        fetchRequest.predicate = predicate
        
        let fetchResults = try? context.fetch(fetchRequest) as! [VKMCurrentUser]
        
        if (fetchResults!.count == 1)
        {
            let user = fetchResults![0]
            
            user.access_token = access_token
            
            return user
        }
        else
        {
            let user = NSEntityDescription.insertNewObject(forEntityName: "VKMCurrentUser", into: context) as! VKMCurrentUser
            
            user.id = id
            user.access_token = access_token
            
            return user
        }
    }
    
    //MARK: получение залогиненого пользователя
    class func currentUserInMainContext () -> VKMCurrentUser?
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "VKMCurrentUser")
        let fetchResults = try? VKMCoreDataManager.sharedInstsnce.managedObjectContext.fetch(fetchRequest) as! [VKMCurrentUser]
        
        if (fetchResults!.count == 1)
        {
            let user = fetchResults![0]
            
            return user
        }

        return nil
    
    }
}
