//
//  PersistenceTests.swift
//  MessengerTests
//
//  Created by Canh Tran Wizeline on 3/11/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import XCTest
@testable import Messenger

final class PersistenceTests: MessengerTests {

    private let messageDataStore = MessagesDataStore()
    private let userId = "testID"
    
    func testStoringMessages() {
        let messages = [
            Message(createdAt: Date(), avatarURL: nil, userName: nil, text: "Dummy text 1"),
            Message(createdAt: Date(), avatarURL: nil, userName: "canhtran", text: "Dummy text 2"),
            Message(createdAt: Date(), avatarURL: nil, userName: nil, text: "Dummy text 3")
        ]
        messageDataStore.saveMessages(messages, userId: userId)
        
        XCTAssertNotNil(messageDataStore.getMessages(userId: userId), "Should store list of message succesfully.")
    }
}
