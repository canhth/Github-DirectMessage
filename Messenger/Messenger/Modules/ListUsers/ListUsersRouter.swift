// 
//  ListUsersRouter.swift
//  Messenger
//
//  Created by Canh Tran Wizeline on 3/10/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class ListUsersRouter: NavigationRouter {
}

// MARK: - ListUsersRouterInterface

extension ListUsersRouter: ListUsersRouterInterface {
    func openDirectMessage(with user: User) {
        let view = DirectMessagesDependency().makeDirectMessagesView(with: user)
        push(view, animated: true)
    }
}
