//
//  BaseView.swift
//  Messanger
//
//  Created by Gregory House on 22.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

protocol BaseView: NSObjectProtocol
{
    func assignPresenter(presenter: BasePresenter) -> Void
    func reloadData () -> Void
}
