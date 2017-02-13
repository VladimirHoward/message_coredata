//
//  VKMDialogsOperation.swift
//  Messanger
//
//  Created by Admin on 28.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

class VKMDialogsOperation: Operation
{
    let context = VKMCoreDataManager.sharedInstance.privateContext()
    
    var count : Int
    var offset : Int
    var success : () -> Void
    var failure : (Int) -> Void
    
    var internetTask : URLSessionDataTask?
    
    init ( with count: Int, offset: Int, success : @escaping () -> Void, failure : @escaping (Int) -> Void)
    {
        self.count = count
        self.offset = offset
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
        
            let rawItems = jsonResponse["response"]
            let items = rawItems["items"].arrayValue
            
            var usersArray = ""

    
            for dialog in items
            {
                let message = dialog["message"]
                
                let chatID = message["chat_id"].int64Value
                
                let senderUserID = message["user_id"].int64Value
                let title = message["title"].stringValue
                let unread = message["read_state"].int64Value
                let out = message["read_state"].int64Value
                var body = message["body"].stringValue
                let multichatURL = message["photo_100"].stringValue
                let date = message["date"].int64Value
                
                if body == ""
                {
                    let attachment = message["attachments"].arrayValue
                    var tempBody = ""
                    
                    for attach in attachment
                    {
                        let type = attach["type"].stringValue
                        
                        if type == "photo"
                        {
                            tempBody = "Фотография"
                        }
                        if type == "video"
                        {
                            tempBody = "Видеозапись"
                        }
                        if type == "audio"
                        {
                            tempBody = "Аудиозапись"
                        }
                        if type == "doc"
                        {
                            tempBody = "Документ"
                        }
                        if type == "link"
                        {
                            tempBody = "Ссылка"
                        }
                        if type == "market"
                        {
                            tempBody = "Товар"
                        }
                        if type == "market_album"
                        {
                            tempBody = "Подборка товаров"
                        }
                        if type == "wall"
                        {
                            tempBody = "Запись на стене"
                        }
                        if type == "wall_reply"
                        {
                            tempBody = "Комментарий на стене"
                        }
                        if type == "sticker"
                        {
                            tempBody = "Стикер"
                        }
                        if type == "gift"
                        {
                            tempBody = "Подарок"
                        }
                        
                        body = body + ", " + tempBody
                    }
                }
                
                
            if chatID != 0 //диалог с пользователЯМИ
            {
                
                let chatUsers = message["chat_active"].arrayValue
                
                for users in chatUsers
                {
                    let user = users.int64Value
                    
                    if !(VKMUserFabric.checkUser(withID: user, context: self.context))
                    {
                        usersArray += "\(user),"
                    }
                }
                
                _ = VKMMultichatFabric.createOrUpdateMessage(withId: chatID, senderUserID: senderUserID, title: title, unread: unread, out: out, body: body, multichatPicURL: multichatURL, userIDs: usersArray, createdAt: date, context: self.context)
                
            }
            else //диалог с пользователем
            {
                
                
                if !(VKMUserFabric.checkUser(withID: senderUserID, context: self.context))
                {
                    usersArray += "\(senderUserID),"
                }
                
                _ = VKMChatRoomFabric.createOrUpdateMessage(withId: senderUserID, senderUserID: senderUserID, title: title, unread: unread, out: out, body: body, userIDs: String(senderUserID), createdAt: date, context: self.context)
                
            }
        }
            
            if usersArray != ""
            {
                usersArray.remove(at: usersArray.index(before: usersArray.endIndex))
            }
            
            print("\(usersArray)")
            
            self.internetTask = API_WRAPPER.getUsers(withIds: usersArray, successBlock: { (jsonResponse) in
                    
                let users = jsonResponse["response"].arrayValue
                    
                for user in users
                {
                    let name = user["first_name"].stringValue + " " + user["last_name"].stringValue
                    let userId = user["id"].int64Value
                    let avatarURL = user["photo_100"].stringValue
                        
                    _ = VKMUserFabric.createOrUpdateMessage(withUserId: userId, avatarURL: avatarURL, name: name, context: self.context)
                }
                    
                    if ( self.isCancelled != true )
                    {
                       print("СОХРАНИЛИ ДИАЛОГИ")
                        _ = try? self.context.save()
                        self.success()
                    }
                    else
                    {
                        self.success()
                    }
                    
                    semaphore.signal()
                    
                    
                }, failureBlock: self.failure)
            
    
        }, failureBlock: failure)
    
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }
}
