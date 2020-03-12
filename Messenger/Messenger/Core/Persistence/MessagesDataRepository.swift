//
//  MessagesDataRepository.swift
//  Messenger
//
//  Created by Canh Tran Wizeline on 3/9/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import Foundation

final class MessagesDataStore {
    
    private let dataStore: DataStore
    
    init(dataStore: DataStore = UserDefaultsDataStore.shared) {
        self.dataStore = dataStore
    }
    
    func getMessages(userId: String) -> [Message]? {
        return dataStore.getModel(key: .message(userId: userId))
    }
    
    func saveMessages(_ messages: [Message], userId: String) {
        dataStore.setModel(key: .message(userId: userId), value: messages)
    }
}
