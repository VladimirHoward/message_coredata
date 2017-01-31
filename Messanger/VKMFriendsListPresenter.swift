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
    
    private var totalCount = 0
    private var pageSize = 50
    
    private weak var view: BaseView?
    
    private let modelsDictionary = NSMutableDictionary()
    
    func assignView( view: BaseView) -> Void
    {
        self.view = view
    }
    
    func viewLoaded() -> Void
    {
        loadModels(withOffset: 0, count: 50)
    }
    
    func refreshData ()
    {
        totalCount = 0
        let allCount = dataSource.count
        dataSource.removeAllObjects()
        loadModels(withOffset: 0, count: allCount)
    }
    
    func getModel (atIndexPath indexPath: NSIndexPath) -> Any
    {
        let model = dataSource[indexPath.row] as! VKMFriend
        
        if (indexPath.row == dataSource.count - 1)
        {
            if dataSource.count == totalCount
            {
                return model
            }
            
            loadModels(withOffset: dataSource.count, count: pageSize)
        }
        return model
    }
    
    func getModelsCount () -> Int
    {
        return dataSource.count
    }
    
    func loadModels (withOffset offset: Int, count: Int) -> Void
    {
        
        VKMFriendsManager.getFriends(count: count, offset: offset, success: { [weak self] (data, count) in
            
          
                DispatchQueue.main.async {
                    if (self != nil)
                    {
                        self!.totalCount = count
                        self!.dataSource.addObjects(from: data as! [Any])
                        self!.view?.reloadData()
                    }
                }
            
        }) { [weak self] (errorCode) in
            
        }
        
//        VKMFriendsManager.getFriends(count: count, offset: offset, success: {[weak self] (data) in
//
//            DispatchQueue.main.async {
//                self?.dataSource.addObjects(from: data as! [Any])
//                self?.view?.reloadData()
//            }
//            
//        }, failure: {[weak self] (errorCode) in
//            
//        })
        view?.reloadData()
    }
}
