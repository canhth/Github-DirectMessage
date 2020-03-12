//
//  MessageInputView.swift
//  Messenger
//
//  Created by Canh Tran Wizeline on 3/10/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import UIKit

final class MessageInputView: UIView {
    
    private enum DesignConstraints {
        static let textViewBaseMargin: CGFloat = 12
        static let postButtonWidth: CGFloat = 40
        static let postPaddingBottom: CGFloat = 10
        static let textInputMaxHeight: CGFloat = 55
        static let textInputMinHeight: CGFloat = 35
        static let inputTextPlaceHolder = "Type your message here..."
    }
    
    // MARK: - Properties
    private let topSeparateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.4)
        return view
    }()
    
    private lazy var growingInputTextView: GrowingTextView = {
        let textView = GrowingTextView()
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = Color.black
        textView.backgroundColor = Color.lightBackground.withAlphaComponent(0.7)
        textView.maxLength = 1000
        textView.minHeight = DesignConstraints.textInputMinHeight
        textView.layer.cornerRadius = DesignConstraints.textInputMinHeight / 2
        textView.maxHeight = DesignConstraints.textInputMaxHeight
        textView.placeholder = DesignConstraints.inputTextPlaceHolder
        textView.placeholderColor = .lightGray
        return textView
    }()
    
    private let postButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(postMessageDidTapped), for: .touchUpInside)
        return button
    }()
    
    private let backgroundInputView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = DesignConstraints.textInputMinHeight / 2
        return backgroundView
    }()
    
    // MARK: Public
    var sendMessageButtonDidTapped: ((_ text: String) -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        
        addSubview(topSeparateView)
        topSeparateView.anchor(top: topAnchor,
                               left: leftAnchor,
                               right: rightAnchor,
                               height: Constraints.lineHeight)
        
        addSubview(postButton)
        postButton.anchor(right: rightAnchor,
                          paddingRight: Constraints.basePadding,
                          width: DesignConstraints.postButtonWidth)
        
        addSubview(backgroundInputView)
        backgroundInputView.anchor(top: topAnchor,
                                   left: leftAnchor,
                                   bottom: bottomAnchor,
                                   right: postButton.leftAnchor,
                                   paddingTop: DesignConstraints.textViewBaseMargin,
                                   paddingLeft: Constraints.paddingX2,
                                   paddingBottom: DesignConstraints.textViewBaseMargin,
                                   paddingRight: Constraints.basePadding)
        postButton.anchorCenter(vertical: backgroundInputView.centerYAnchor)
        
        backgroundInputView.addSubview(growingInputTextView)
        growingInputTextView.anchor(top: backgroundInputView.topAnchor,
                                    left: backgroundInputView.leftAnchor,
                                    bottom: backgroundInputView.bottomAnchor,
                                    right: backgroundInputView.rightAnchor,
                                    paddingLeft: Constraints.paddingX2)
    }
    
    @objc
    private func postMessageDidTapped() {
        guard let text = growingInputTextView.text, !text.isEmpty else { return }
        growingInputTextView.text = ""
        growingInputTextView.resignFirstResponder()
        sendMessageButtonDidTapped?(text)
    }
}

extension MessageInputView: GrowingTextViewDelegate {
    // Call layoutIfNeeded on superview for animation when changing height
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
            self.superview?.layoutIfNeeded()
        }, completion: nil)
    }
}
