//
//  VKMDialogForTwo.swift
//  Messanger
//
//  Created by Gregory House on 29.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class VKMDialogForTwo: VKMDialog
{
    var mId: Int64 //id сообщения
    var uId: Int64 //id собеседника
    var title: String //название беседы
    var body: String //тело сообщения
    var out: Int64 // 0 - получено, 1 - отправлено
    
    init(WithMessegeId mId: Int64, uId: Int64, title: String, body: String, out: Int64, type: Int)
    {
        self.mId = mId
        self.uId = uId
        self.title = title
        self.body = body
        self.out = out
        super.init(WithType: type)
    }

}
