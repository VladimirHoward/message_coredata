//
//  API_WRAPPER.swift
//  vk_news
//
//  Created by Gregory House on 02.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation
import SwiftyJSON

class API_WRAPPER
{
    class func composeGenericHTTPGetRequest (forBaseURL baseURL: String, andMethod method: String, withParametrs parametrs: NSDictionary) -> NSURLRequest
    {
        var requestString = baseURL + method + "?"
        
        let keysArray = parametrs.allKeys as! [String]
        
        for i in 0..<keysArray.count
        {
            let key = keysArray[i]
            let value = parametrs[key] as! String
            
        
                requestString += "\(key)=\(value)&"
        }
        
        requestString += "v=5.62"
        
        print("\n\n\n строка запроса - \(requestString)\n\n\n")
        
        let request = NSMutableURLRequest ()
        request.httpMethod = "GET"
        request.url = URL(string: requestString)
        
        return request
    }
}

//MARK получение списка друзей
extension API_WRAPPER
{
    class func getFriends (withCount count : Int, offset : Int, successBlock: @escaping (_ jsonResponce: JSON) -> Void, failureBlock: @escaping (_ errorCode: Int) -> Void) -> URLSessionDataTask
    {
        let argsDictionary = NSMutableDictionary ()
        
        argsDictionary.setObject("\(count)", forKey: ACConst.URLConst.Arguments.kCount)
        argsDictionary.setObject("photo_100", forKey: ACConst.URLConst.Arguments.kFields)
        argsDictionary.setObject("hints", forKey: ACConst.URLConst.Arguments.kOrder)
        argsDictionary.setObject("\(offset)", forKey: ACConst.URLConst.Arguments.kOffset)

        argsDictionary.setObject(VKMCurrentUserFabric.currentUserInMainContext()!.access_token, forKey: ACConst.URLConst.Arguments.kAccessToken)
        
        let request = composeGenericHTTPGetRequest(forBaseURL: ACConst.URLConst.kBaseURL, andMethod: ACConst.URLConst.Scripts.kFriendsGet, withParametrs: argsDictionary)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            genericCompletetionCallback(withResponseData: data, response: response, error: error, successBlock: successBlock, failureBlock: failureBlock)
        }
        
        task.resume()
        
        return task
    }
}


//MARK получение списка диалогов
extension API_WRAPPER
{
    class func getDialogs (withCount count: Int, offset: Int, successBlock: @escaping (_ jsonResponce: JSON) -> Void, failureBlock: @escaping (_ errorCode: Int) -> Void) -> URLSessionDataTask
    {
        let argsDictionary = NSMutableDictionary ()
        
        argsDictionary.setObject("\(count)", forKey: ACConst.URLConst.Arguments.kCount)
        argsDictionary.setObject(ACAuthManager.sharedInstance.getAccessToken(), forKey: ACConst.URLConst.Arguments.kAccessToken)
        
        let request = composeGenericHTTPGetRequest(forBaseURL: ACConst.URLConst.kBaseURL, andMethod: ACConst.URLConst.Scripts.kMethodMessage, withParametrs: argsDictionary)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            genericCompletetionCallback(withResponseData: data, response: response, error: error, successBlock: successBlock, failureBlock: failureBlock)
        }
        
        task.resume()
        return task
    }
}

//MARK: получение информации о пользователе
extension API_WRAPPER
{
    class func getUsers (withIds ids: String, successBlock: @escaping (_ jsonResponse: JSON) -> Void, failureBlock: @escaping (_ errorCode: Int) -> Void) -> URLSessionDataTask
    {
        let agrsDictionary = NSMutableDictionary ()
        
        agrsDictionary.setObject("\(ids)", forKey: ACConst.URLConst.Arguments.kUser)
        agrsDictionary.setObject("photo_100", forKey: ACConst.URLConst.Arguments.kFields)
        agrsDictionary.setObject(ACAuthManager.sharedInstance.getAccessToken(), forKey: ACConst.URLConst.Arguments.kAccessToken)
        
        let request = composeGenericHTTPGetRequest(forBaseURL: ACConst.URLConst.kBaseURL, andMethod: ACConst.URLConst.Scripts.kMethodUser, withParametrs: agrsDictionary)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            genericCompletetionCallback(withResponseData: data, response: response, error: error, successBlock: successBlock, failureBlock: failureBlock)
        }
        
        task.resume()
        return task
    }
}


//MARK: общий обработчик ответов для JSON
extension API_WRAPPER
{
    class func genericCompletetionCallback (withResponseData data: Data?, response: URLResponse?, error: Error?, successBlock: (_ jsonResponse: JSON) -> Void, failureBlock: (_ errorCode: Int) -> Void)
    {
        if (error != nil)
        {
            failureBlock((error as! NSError).code)
        }
        
        if (data != nil)
        {
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                let swiftyJSON = JSON(json)
                print("ответ - \(swiftyJSON)")
                successBlock(swiftyJSON)
            }
            catch
            {
                failureBlock(-80)
            }
        }
        else
        {
            failureBlock(-80)
        }
    }
}

