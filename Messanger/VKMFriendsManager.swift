//
//  VKMFriendsManager.swift
//  Messanger
//
//  Created by Gregory House on 22.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class VKMFriendsManager
{
    class func getFriends (count: Int, offset: Int, success: @escaping (NSArray, Int) -> Void, failure: @escaping (Int) -> Void)
    {
        let operation = VKMFriendsGetOperations(withCount: count, offset: offset, success: success, failure: failure)
        VKMOperationsManagers.addBusinessLogicOperation(op: operation, cancellingQueue: true)
    }
}
