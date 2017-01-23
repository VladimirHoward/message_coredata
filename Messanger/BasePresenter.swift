//
//  BasePresenter.swift
//  Messanger
//
//  Created by Gregory House on 22.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

protocol BasePresenter
{

    func assignView( view: BaseView) -> Void
    func viewLoaded() -> Void
    func getModel (atIndexPath indexPath: NSIndexPath) -> Any
    func getModelsCount () -> Int
    func loadModels (withOffset offset: Int, count: Int) -> Void
    
}
