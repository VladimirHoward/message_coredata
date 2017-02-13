//
//  BaseView.swift
//  Messenger
//
//  Created by MacAdmin on 22.01.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import Foundation

@objc protocol BaseView : NSObjectProtocol
{
    func assignPresenter ( presenter : BasePresenter ) -> Void
    func reloadData () -> Void
    
    @objc optional func beginUIUpdates ()
    @objc optional func endUIUpdates ()
    @objc optional func insertRows (atIndexPath path: [IndexPath])
    @objc optional func deleteRows (atIndexPath path: [IndexPath])
    @objc optional func moveRow (at: IndexPath, to: IndexPath)
    @objc optional func updateRow (at: IndexPath)
    
}
