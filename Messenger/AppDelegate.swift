//
//  AppDelegate.swift
//  Messenger
//
//  Created by MacAdmin on 15.01.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        let shouldLogin = ACAuthManager.sharedInstance.shouldLogin()
        
        var initialVCID = ""
        
        if ( shouldLogin )
        {
            initialVCID = ACConst.UIConst.kLoginScreenIdentifier
        }
        else
        {
            initialVCID = ACConst.UIConst.kTabbarScreenIdentifier
        }
        
        let initialVC = ACViewControllersFabric.getViewController(withIdentifier: initialVCID)
        
        
        self.window?.rootViewController = initialVC
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
        VKMCoreDataManager.sharedInstance.save()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool
    {
        return ACAuthManager.sharedInstance.processOpenURL(url: url, fromApplication: sourceApplication)
    }
}

