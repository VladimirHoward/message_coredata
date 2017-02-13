//
//  VKMOperationsManager.swift
//  Messenger
//
//  Created by MacAdmin on 22.01.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import Foundation

class VKMOperationsManager
{
    private static let businessLogicOperationQueue = OperationQueue()
    
    class func addBusinessLogicOperation ( op : Operation , cancellingQueue flag : Bool )
    {
        businessLogicOperationQueue.maxConcurrentOperationCount = 1
        
        if flag
        {
            businessLogicOperationQueue.cancelAllOperations()
        }
        
        businessLogicOperationQueue.addOperation(op)
    }
}
