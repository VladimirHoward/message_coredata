//
//  VKMCurrentUser.swift
//  Messenger
//
//  Created by MacAdmin on 15.01.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import Foundation
import CoreData

class VKMCurrentUser : NSManagedObject
{
    @NSManaged var id : Int64
    @NSManaged var access_token : String
}
