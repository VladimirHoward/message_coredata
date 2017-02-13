//
//  VKMDependencyInjector.swift
//  Messenger
//
//  Created by MacAdmin on 22.01.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import Foundation

class VKMDependencyInjector
{
    class func assignPresenter ( forView view : BaseView )
    {
        var presenter : BasePresenter?
        
        if ( view is VKMFriendsListViewController )
        {
            presenter = VKMFriendsListPresenter()
        }
        
        if ( view is VKMDialogsListViewController )
        {
            presenter = VKMDialogsListPresenter()
        }

        
        if presenter != nil
        {
            view.assignPresenter(presenter: presenter!)
            presenter?.assignView(view: view)
        }
    }
}
