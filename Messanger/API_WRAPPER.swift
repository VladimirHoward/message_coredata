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

        
//        print("\n\n\n строка запроса - \(requestString)\n\n\n")
        
        let request = NSMutableURLRequest ()
        request.httpMethod = "GET"
        request.url = URL(string: requestString)
        
        return request
    }
}



//MARK получение списка друзей
extension API_WRAPPER
{
    class func getFriends (withCount count: Int, offset: Int, successBlock: @escaping (_ jsonResponce: JSON) -> Void, failureBlock: @escaping (_ errorCode: Int) -> Void) -> URLSessionDataTask
    {
        let argsDictionary = NSMutableDictionary ()
        
        argsDictionary.setObject("\(count)", forKey: ACConts.URLConst.Arguments.kCount)
        argsDictionary.setObject("\(offset)", forKey: ACConts.URLConst.Arguments.kOffset)

        argsDictionary.setObject("photo_100", forKey: ACConts.URLConst.Arguments.kFields)
        argsDictionary.setObject("hints", forKey: ACConts.URLConst.Arguments.kOrder)
        

        argsDictionary.setObject(VKMCurrentUserFabric.currentUserInMainContext()!.access_token, forKey: ACConts.URLConst.Arguments.kAccessToken)
        
        let request = composeGenericHTTPGetRequest(forBaseURL: ACConts.URLConst.kBaseURL, andMethod: ACConts.URLConst.Scripts.kFriendsGet, withParametrs: argsDictionary)
        
        print("\(request)")
        
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
        
        argsDictionary.setObject("\(count)", forKey: ACConts.URLConst.Arguments.kCount)
        argsDictionary.setObject("\(offset)", forKey: ACConts.URLConst.Arguments.kOffset)
        argsDictionary.setObject(VKMCurrentUserFabric.currentUserInMainContext()!.access_token, forKey: ACConts.URLConst.Arguments.kAccessToken)
        
        let request = composeGenericHTTPGetRequest(forBaseURL: ACConts.URLConst.kBaseURL, andMethod: ACConts.URLConst.Scripts.kDialogsGet, withParametrs: argsDictionary)
        
        print("\(request)")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
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
//                print(swiftyJSON)
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


