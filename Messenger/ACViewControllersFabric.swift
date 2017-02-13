//
//  ACViewControllersFabric.swift
//  Messenger
//
//  Created by MacAdmin on 22.01.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import UIKit

class ACViewControllersFabric
{
    class func getViewController ( withIdentifier identifier : String ) -> UIViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
