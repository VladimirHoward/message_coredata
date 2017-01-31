//
//  VKMDialogsGetOperation.swift
//  Messanger
//
//  Created by Gregory House on 28.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class VKMDialogsGetOperation: Operation
{
    
    var offset: Int
    var count: Int
    var success: (NSArray) -> Void
    var failure: (Int) -> Void
    
    var internetTask: URLSessionDataTask?
    
    init(withCount count: Int, offset: Int, success: @escaping (NSArray) -> Void, failure: @escaping (Int) -> Void)
    {
        self.offset = offset
        self.count = count
        self.success = success
        self.failure = failure
    }
    
    override func cancel()
    {
        internetTask?.cancel()
    }
    
    override func main()
    {
        let semaphore = DispatchSemaphore(value: 0)
        
        internetTask = API_WRAPPER.getDialogs(withCount: count, offset: offset, successBlock: { (jsonResponse) in
            
            let outArray = NSMutableArray()
            
            let dialogs = jsonResponse["response"].arrayValue.dropFirst()
            
            for dialog in dialogs
            {
                let chatId = dialog["chat_id"].int64
                
                if chatId == nil
                {
                    let mId = dialog["mid"].int64Value
                    let uId = dialog["uid"].int64Value
                    let title = dialog["title"].stringValue
                    let body = dialog["body"].stringValue
                    let out = dialog["out"].int64Value
                    
                    let tempDialogForTwo = VKMDialogForTwo(WithMessegeId: mId, uId: uId, title: title, body: body, out: out, type: 0)
                    outArray.add(tempDialogForTwo)
                }
                else
                {
                    let mId = dialog["mid"].int64Value
                    let uId = dialog["uid"].int64Value
                    let chatId = dialog["chat_id"].int64Value
                    let rawChatMembers = dialog["chat_active"].stringValue
                    let chatMembers = rawChatMembers.components(separatedBy: ",")
                    let title = dialog["title"].stringValue
                    let body = dialog["body"].stringValue
                    let out = dialog["out"].int64Value
                    
                    let tempDialogChat = VKMDialogChat(WithMessegeId: mId, uId: uId, chatMembers: chatMembers, title: title, body: body, out: out, type: 1, chatId: chatId)
                    outArray.add(tempDialogChat)
                }
            }
            
            if (self.isCancelled != nil)
            {
                self.success(outArray)
            }
            else
            {
                self.success(NSArray())
            }
            
            semaphore.signal()
            
        }, failureBlock: { (errorCode) in
            
            self.failure(errorCode)
            semaphore.signal()
            
        })
        
        _ = semaphore.wait(timeout: .distantFuture)
    }
}
