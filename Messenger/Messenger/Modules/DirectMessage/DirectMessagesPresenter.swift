// 
//  DirectMessagesPresenter.swift
//  Messenger
//
//  Created by Canh Tran Wizeline on 3/10/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class DirectMessagesPresenter {
    // MARK: - Private Properties

    private unowned let view: DirectMessagesViewInterface
    private let interactor: DirectMessagesInteractorInterface
    private let router: DirectMessagesRouterInterface
    private let user: User
    
    private var listMessages: [Message] = [] {
        didSet {
            view.reloadData()
        }
    }
    
    // MARK: - LifeCycle

    init(view: DirectMessagesViewInterface,
         interactor: DirectMessagesInteractorInterface,
         router: DirectMessagesRouterInterface,
         user: User) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.user = user
    }

    func viewDidLoad() {
        fetchListMessages()
    }
}

// MARK: - DirectMessagesPresenterInterface

extension DirectMessagesPresenter: DirectMessagesPresenterInterface {
    
    func getUserName() -> String {
        return "@" + user.login
    }
    
    func numberOfMessages() -> Int {
        return listMessages.count
    }
    
    func messageAtIndex(index: Int) -> Message? {
        return listMessages[safe: index]
    }
    
    func fetchListMessages() {
        interactor.fetchListMessages(with: user.id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let messages):
                self.listMessages.append(contentsOf: messages)
            case .failure:
                Logger.shared.error(object: "Empty!! Or should not occurred error here.")
            }
        }
    }
    
    func createNewMessage(with text: String) {
        // Move to interactor to store this message.
        // then call an API to send the message and recieve the next message after 1 sec
        let message = Message(createdAt: Date(), avatarURL: nil, userName: nil, text: text)
        listMessages.append(message)
        
        interactor.createNewMessage(message, user: user) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let message):
                self.listMessages.append(message)
                self.interactor.storeMessages(messages: self.listMessages, userId: self.user.id)
            case .failure:
                Logger.shared.error(object: "Should not occurred error here.")
            }
        }
    }
    
}
