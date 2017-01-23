//
//  VKMDependencyInjector.swift
//  Messanger
//
//  Created by Gregory House on 22.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class VKMDependencyInjector
{
    class func assignPresenter (forView view: BaseView)
    {
        var presenter: BasePresenter?
        
        if ( view is VKMFriendsListViewController)
        {
            presenter = VKMFriendsListPresenter()
        }
        
        if presenter != nil
        {
            view.assignPresenter(presenter: presenter!)
            presenter?.assignView(view: view)
        }
    }
}
