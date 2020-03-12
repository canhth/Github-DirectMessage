//
//  ListUsersTests.swift
//  MessengerTests
//
//  Created by Canh Tran Wizeline on 3/11/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import XCTest
@testable import Messenger

final class ListUsersTests: MessengerTests {
   
    private var lastUserId = 0
    private let viewController = ListUsersViewController()
    private lazy var presenter = ListUsersPresenter(view: viewController,
                                                    interactor: ListUsersInteractor(),
                                                    router: ListUsersRouter(rootController: UINavigationController()))
    override func setUp() {
        super.setUp()
        viewController.presenter = presenter
    }

    /// Test Presenter gets list users by network
    func testFetchingUsersByNetwork() {
        let expect = expectation(description: "test_listusers_by_network")
        presenter.fetchListUsers()
        DispatchQueue.main.asyncAfter(deadline: .now() + limitTimeOut - 1) {
            expect.fulfill()
        }
        
        waitForExpectations(timeout: limitTimeOut) { [unowned self] error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            } else {
                XCTAssertEqual(self.presenter.numberOfUsers(), 30)
            }
        }
    }
    
    func testFetchingUserByMockData() {
        let mockInteractor = MockListUsersInteractor()
        presenter = ListUsersPresenter(view: viewController,
                                       interactor: mockInteractor,
                                       router: ListUsersRouter(rootController: UINavigationController()))
        viewController.presenter = presenter
        
        presenter.fetchListUsers()
        XCTAssertEqual(self.presenter.numberOfUsers(), 30)
    }
}
