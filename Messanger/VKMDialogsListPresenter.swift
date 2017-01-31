//
//  VKMDialogsListPresenter.swift
//  Messanger
//
//  Created by Gregory House on 28.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class VKMDialogsListPresenter: BasePresenter
{
    private let dataSource = NSMutableArray()
    private weak var view: BaseView?
    
    func assignView(view: BaseView) -> Void
    {
        self.view = view
    }
    
    func viewLoaded() -> Void
    {
        loadModels(withOffset: 0, count: 10)
    }
    
    func refreshData() -> Void
    {
    
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
        VKMDialogsManager.getDialogs(count: count, offset: offset, success: { [weak self] (data) in
            
            DispatchQueue.main.async
            {
                self?.dataSource.addObjects(from: data as! [Any])
                self?.view?.reloadData()
            }
            
        }) { [weak self] (errorCode) in
            
        }
        view?.reloadData()
    }
}
