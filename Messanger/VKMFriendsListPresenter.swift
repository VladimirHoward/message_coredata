//
//  VKMFriendsListPresenter.swift
//  Messanger
//
//  Created by Gregory House on 22.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

//MARK: интерфейс
class VKMFriendsListPresenter: BasePresenter
{
    private let dataSource = NSMutableArray()
    private weak var view: BaseView?
    
    func assignView( view: BaseView) -> Void
    {
        self.view = view
    }
    
    func viewLoaded() -> Void
    {
        loadModels(withOffset: 0, count: 50)
    }
    
    func getModel (atIndexPath indexPath: NSIndexPath) -> Any
    {
        return dataSource[indexPath.row]
    }
    
    func getModelsCount () -> Int
    {
        return dataSource.count
    }
    
    func loadModels (withOffset offset: Int, count: Int) -> Void
    {
        VKMFriendsManager.getFriends(count: count, offset: offset, success: {[weak self] (data) in
        
            DispatchQueue.main.async {
                self?.dataSource.addObjects(from: data as! [Any])
                self?.view?.reloadData()
            }
            
        }, failure: {[weak self] (errorCode) in
            
        })
        view?.reloadData()
    }
}
