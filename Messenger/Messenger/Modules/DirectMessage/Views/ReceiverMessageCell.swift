//
//  ReceiverMessageCell.swift
//  Messenger
//
//  Created by Canh Tran Wizeline on 3/10/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import UIKit

final class ReceiverMessageCell: SenderMessageCell {
    
    private enum DesignConstraints {
        static let profileImageSize = CGSize(width: 25, height: 25)
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = DesignConstraints.profileImageSize.width / 2
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "user_placeholder")
        return imageView
    }()
    
    override func setupViews() {
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor,
                                bottom: bottomAnchor,
                                paddingLeft: Constraints.basePadding,
                                paddingBottom: Constraints.basePadding,
                                width: DesignConstraints.profileImageSize.width,
                                height: DesignConstraints.profileImageSize.height)
        
        addSubview(messageBackgroundImageView)
        addSubview(messageLabel)
        
        messageLabel.anchor(top: topAnchor,
                            left: profileImageView.rightAnchor,
                            paddingTop: Constraints.paddingX3,
                            paddingLeft: Constraints.paddingX3)
        messageLabel.bottomAnchor
            .constraint(equalTo: bottomAnchor, constant: -Constraints.paddingX3)
            .set(priority: .defaultLow)
        
        messageLabelWidthConstraint = messageLabel.widthAnchor
            .constraint(equalToConstant: 0).set(active: true)
        messageLabelHeightConstraint = messageLabel.heightAnchor
            .constraint(equalToConstant: DesignConstraints.minHeight).set(active: true)
        
        messageBackgroundImageView.anchor(top: messageLabel.topAnchor,
                                          left: messageLabel.leftAnchor,
                                          bottom: messageLabel.bottomAnchor,
                                          right: messageLabel.rightAnchor,
                                          paddingTop: -Constraints.paddingX2,
                                          paddingLeft: -Constraints.paddingX3,
                                          paddingBottom: -Constraints.paddingX2,
                                          paddingRight: -Constraints.paddingX2)
        let image = UIImage(named: "left_bubble")
        messageBackgroundImageView.image = image?.resizableImage(withCapInsets: DesignConstraints.cornerInsets,
                                                                 resizingMode: .stretch)
    }
    
    override func configCell(with message: Message) {
        messageLabel.text = message.text
        let estimateFrame = message.text.getEstimateFrame(width: Constraints.maxWidth - DesignConstraints.profileImageSize.width,
                                                          height: CGFloat.greatestFiniteMagnitude)
        
        messageLabelWidthConstraint?.constant = estimateFrame.width + Constraints.basePadding
        messageLabelHeightConstraint?.constant = estimateFrame.height + Constraints.basePadding
        layoutIfNeeded()
        
        if let url = message.avatarUrl {
            profileImageView.loadImage(urlString: url)
        }
    }
}
