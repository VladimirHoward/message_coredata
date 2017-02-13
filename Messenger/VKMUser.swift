//
//  VKMUser.swift
//  Messenger
//
//  Created by Gregory House on 05.02.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import Foundation
import CoreData

class VKMUser: NSManagedObject
{
    @NSManaged var id: Int64
    @NSManaged var name: String
    @NSManaged var avatarURL: String
}
