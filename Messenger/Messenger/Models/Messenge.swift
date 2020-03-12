//
//  Message.swift
//  Messenger
//
//  Created by Canh Tran Wizeline on 3/9/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import Foundation

enum MessengeType: String, Codable {
    case sender
    case receiver
}

struct Message: Codable {
    let createdAt: Date
    let userName: String?
    let avatarUrl: String?
    let text: String
    let type: MessengeType
    
    init(createdAt: Date, avatarURL: String?, userName: String?, text: String) {
        self.createdAt = createdAt
        self.userName = userName
        self.text = text
        self.avatarUrl = avatarURL
        type = userName == nil ? .sender : .receiver
    }
}
