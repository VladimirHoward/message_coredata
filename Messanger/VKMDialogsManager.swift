//
//  VKMDialogsManager.swift
//  Messanger
//
//  Created by Gregory House on 28.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class VKMDialogsManager
{
    class func getDialogs (count: Int, offset: Int, success: @escaping (NSArray) -> Void, failure: @escaping (Int) -> Void)
    {
        let operation = VKMDialogsGetOperation(withCount: count, offset: offset, success: success, failure: failure)
        
        VKMOperationsManagers.addBusinessLogicOperation(op: operation, cancellingQueue: true)
    }
}
