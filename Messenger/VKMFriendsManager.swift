//
//  VKMFriendsManager.swift
//  Messenger
//
//  Created by MacAdmin on 22.01.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import Foundation

class VKMFriendsManager
{
    class func getFriends ( count : Int , offset : Int , success : @escaping (NSArray, Int) -> Void , failure : @escaping (Int) -> Void )
    {
        let operation = VKMFriendsGetOperation(withCount: count, offset: offset, success: success, failure: failure)
        VKMOperationsManager.addBusinessLogicOperation(op: operation, cancellingQueue: true)
    }
}
