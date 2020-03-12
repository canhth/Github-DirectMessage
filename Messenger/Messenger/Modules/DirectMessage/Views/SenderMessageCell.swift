//
//  SenderMessageCell.swift
//  Messenger
//
//  Created by Canh Tran Wizeline on 3/10/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import UIKit

class SenderMessageCell: UITableViewCell {
    
    enum DesignConstraints {
        static let cornerInsets = UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21)
        static let minHeight: CGFloat = 24
    }
    
    let messageBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        let image = UIImage(named: "right_bubble")
        imageView.image = image?.resizableImage(withCapInsets: DesignConstraints.cornerInsets,
                                                resizingMode: .stretch)
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    var messageLabelWidthConstraint: NSLayoutConstraint?
    var messageLabelHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Public functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(messageBackgroundImageView)
        addSubview(messageLabel)
        
        messageLabel.anchor(top: topAnchor,
                            right: rightAnchor,
                            paddingTop: Constraints.paddingX3,
                            paddingRight: Constraints.paddingX3)
        messageLabel.bottomAnchor
            .constraint(equalTo: bottomAnchor, constant: -Constraints.paddingX3)
            .set(priority: .defaultLow)
        
        messageLabelWidthConstraint = messageLabel
            .widthAnchor
            .constraint(equalToConstant: 0).set(active: true)
        
        messageLabelHeightConstraint = messageLabel
            .heightAnchor
            .constraint(equalToConstant: DesignConstraints.minHeight).set(active: true)
        
        messageBackgroundImageView.anchor(top: messageLabel.topAnchor,
                                          left: messageLabel.leftAnchor,
                                          bottom: messageLabel.bottomAnchor,
                                          right: messageLabel.rightAnchor,
                                          paddingTop: -Constraints.paddingX2,
                                          paddingLeft: -Constraints.paddingX2,
                                          paddingBottom: -Constraints.paddingX2,
                                          paddingRight: -Constraints.paddingX2)
    }
    
    func configCell(with message: Message) {
        messageLabel.text = message.text
        let estimateFrame = message.text.getEstimateFrame(width: Constraints.maxWidth,
                                                          height: CGFloat.greatestFiniteMagnitude)
        
        messageLabelWidthConstraint?.constant = estimateFrame.width + Constraints.basePadding
        messageLabelHeightConstraint?.constant = estimateFrame.height + Constraints.basePadding
        layoutIfNeeded()
    }
}
