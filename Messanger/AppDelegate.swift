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
        let shouldLogin = ACAuthManager.sharedInstance.shouldLogen()
        var initialVCID = ""
        
        if ( shouldLogin )
        {
            initialVCID = ACConts.UIConst.kLoginScreenIdentifier
        }
        else
        {
            initialVCID = ACConts.UIConst.kTabbarScreenIdentifier
        }
        
        let initialVC = ACViewConterollerFabric.getViewController(withIdentifier: initialVCID)
        
        self.window?.rootViewController = initialVC
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication)
    {
        VKMCoreDataManager.sharedInstsnce.save()
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return ACAuthManager.sharedInstance.processOpenURL(url: url, fromApplication: sourceApplication)
    }
    
}

