//
//  VKMLoginViewController.swift
//  Messanger
//
//  Created by Gregory House on 22.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

//MARK: жизненный цикл
class VKMLoginViewController: UIViewController
{

    var lock = false
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        if ( !lock )
        {
            login()
        }
    }
    
    private func login()
    {
        lock = true
        ACAuthManager.sharedInstance.login(withUnderlayController: self, success: {
        
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
            {
                self.performSegue(withIdentifier: ACConts.UIConst.kLoginTabbarSegueIdentifier, sender: self)
            }
        
        }, failure: {
        
            let alertVC = UIAlertController(title: nil, message: "не удалось войти", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alertVC.addAction(alertAction)
            
            self.present(alertVC, animated: true, completion: nil)
        
        })
    }
    
}

