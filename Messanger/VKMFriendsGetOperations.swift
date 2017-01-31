//
//  VKMFriendsGetOperations.swift
//  Messanger
//
//  Created by Gregory House on 22.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class VKMFriendsGetOperations: Operation
{
    var offset: Int
    var count: Int
    var success: (NSArray, Int) -> Void
    var failure: (Int) -> Void
    
    var internetTask: URLSessionDataTask?
    
    init(withCount count: Int, offset: Int, success: @escaping (NSArray, Int) -> Void, failure: @escaping (Int) -> Void)
    {
        self.offset = offset
        self.count = count
        self.success = success
        self.failure = failure
    }
    
    override func cancel() {
        internetTask?.cancel()
    }
    
    override func main() {
        let semaphore = DispatchSemaphore(value: 0)
        
        internetTask = API_WRAPPER.getFriends(withCount: count, offset: offset, successBlock: { (jsonResponse) in
            
            let outArray = NSMutableArray ()
            
            let friends = jsonResponse["response"]["items"].arrayValue
            let totalCount = jsonResponse["response"]["count"].intValue
            
            for friend in friends
            {
                let id = friend["uid"].stringValue
                let name = friend["first_name"].stringValue+" "+friend["last_name"].stringValue
                let online = friend["online"].intValue
                let avatarURL = friend["photo_100"].stringValue
                
                let localFriend = VKMFriend(withID: id, name: name, online: online, avatarURL: avatarURL)
                
                outArray.add(localFriend)
            }
            
            if (self.isCancelled != nil)
            {
                self.success(outArray, totalCount)
            }
            else
            {
                self.success(NSArray(), totalCount)
            }
            semaphore.signal()

            
        }, failureBlock: { (errorCode) in
            
            self.failure(errorCode)
            semaphore.signal()
            
        })
        
        _ = semaphore.wait(timeout: .distantFuture)
    }
}
