//
//  MockListUsersInteractor.swift
//  MessengerTests
//
//  Created by Canh Tran Wizeline on 3/11/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import XCTest
@testable import Messenger

final class MockListUsersInteractor {
    // MARK: - Private Properties

    private let networkClient: NetworkRequestable

    // MARK: - LifeCycle

    init(networkClient: NetworkRequestable = NetworkClient()) {
        self.networkClient = networkClient
    }
}

// MARK: - ListUsersInteractorInterface

extension MockListUsersInteractor: ListUsersInteractorInterface {
    func fetchListUsers(lastId: Int, completion: @escaping (Result<[User], NetworkError>) -> Void) {
        guard let data = TestSuite().data(fromResource: "listUsers", withExtension: "json") else {
            XCTFail("Can not get the data form listUsers.json")
            return
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let usersList = try decoder.decode([User].self, from: data)
            XCTAssertTrue(usersList.count >= 20, "Should load the list users without error.")
            completion(.success(usersList))
        } catch {
            XCTFail("Can not parse the listUsers.json")
        }
    }
}
