//
//  BasePresenter.swift
//  Messenger
//
//  Created by MacAdmin on 22.01.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import Foundation

@objc protocol BasePresenter
{
    func assignView ( view : BaseView ) -> Void
    func viewLoaded () -> Void
    func resfreshData() -> Void
    func getModel ( atIndexPath indexPath : NSIndexPath ) -> Any
    func getModelsCount () -> Int
    func loadModels ( withOffset offset : Int , count : Int ) -> Void
}
