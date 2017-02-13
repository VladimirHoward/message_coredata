//
//  VKMDialogsManager.swift
//  Messanger
//
//  Created by Admin on 28.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class VKMDialogsManager
{
    class func getDialogs(count : Int, offset: Int, success : @escaping () -> Void, failure : @escaping (Int) -> Void)
    {
        let operation = VKMDialogsOperation(with: count, offset: offset, success: success, failure: failure)
        VKMOperationsManager.addBusinessLogicOperation(op: operation, cancellingQueue: true)
    }
}
