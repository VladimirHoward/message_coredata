//
//  ACViewControllersFabric.swift
//  Messanger
//
//  Created by Gregory House on 22.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit


class ACViewConterollerFabric
{
    class func getViewController (withIdentifier identifier: String) -> UIViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
