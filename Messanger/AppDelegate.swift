//
//  AppDelegate.swift
//  Messanger
//
//  Created by Admin on 15.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
       
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication)
    {
        VKMCoreDataManager.sharedInstsnce.save()
    }

   
    
}

