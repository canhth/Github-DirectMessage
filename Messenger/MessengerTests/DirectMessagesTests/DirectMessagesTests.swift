//
//  DirectMessagesTests.swift
//  MessengerTests
//
//  Created by Canh Tran Wizeline on 3/11/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import XCTest
@testable import Messenger

final class DirectMessagesTests: MessengerTests {
   
    private let interactor = DirectMessagesInteractor()
    
    func testSendingMessage() {
        let dummyUser = User(id: 01,
                             login: "",
                             avatarUrl: nil,
                             url: nil,
                             followersUrl: nil,
                             followingUrl: nil,
                             reposUrl: nil,
                             type: "User")
        let message = Message(createdAt: Date(), avatarURL: nil, userName: nil, text: "Dummy test.")
        let expectedResponse = "Dummy test. Dummy test."
        interactor.createNewMessage(message, user: dummyUser) { (result) in
            switch result {
            case .success(let message):
                XCTAssertEqual(message.text, expectedResponse)
            case .failure:
                XCTFail("Error should not appear when sending the message and waiting for the response.")
            }
        }
    }
    
}
