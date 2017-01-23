//
//  VKMOperationsManagers.swift
//  Messanger
//
//  Created by Gregory House on 22.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class VKMOperationsManagers
{
    private static let businessLogicOperationsQueue = OperationQueue()
    
    class func addBusinessLogicOperation (op: Operation, cancellingQueue flag: Bool)
    {
        businessLogicOperationsQueue.maxConcurrentOperationCount = 1
        
        if flag
        {
            businessLogicOperationsQueue.cancelAllOperations()
        }
        
        businessLogicOperationsQueue.addOperation(op)
        
    }
}
