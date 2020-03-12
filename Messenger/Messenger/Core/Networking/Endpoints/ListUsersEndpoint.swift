//
//  ListUsersAPI.swift
//  Messenger
//
//  Created by Canh Tran Wizeline on 3/9/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import Foundation

enum ListUsersEndpoint {
    case fetchListUser(lastId: Int)
}

// MARK: Confirm protocol Endpoint

extension ListUsersEndpoint: APIEndpoint {
    var method: HTTPMethod {
        return .get
    }

    var path: String {
        switch self {
        case .fetchListUser(let lastId):
            return "/users?since=\(lastId)"
        }
    }

    var parameters: Parameters? {
        return nil
    }

    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        switch self {
        case .fetchListUser:
            decoder.keyDecodingStrategy = .convertFromSnakeCase
        }
        return decoder
    }
}
