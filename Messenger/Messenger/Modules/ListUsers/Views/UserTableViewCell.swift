//
//  UserTableViewCell.swift
//  Messenger
//
//  Created by Canh Tran Wizeline on 3/10/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    
    private enum DesignConstraints {
        static let profileImageSize = CGSize(width: 35, height: 35)
        static let rightImageSize = CGSize(width: 12, height: 12)
        static let basePadding: CGFloat = 12
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = DesignConstraints.profileImageSize.width / 2
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "user_placeholder")
        return imageView
    }()
    
    private let rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "arrow_right")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.lightGray.withAlphaComponent(0.8)
        return imageView
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = Color.black
        return label
    }()
    
    private let separateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        return view
    }()
    
    // MARK: - Public functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userNameLabel.text = ""
        imageView?.image = UIImage(named: "user_placeholder")
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor,
                                left: leftAnchor,
                                bottom: bottomAnchor,
                                paddingTop: Constraints.paddingX2,
                                paddingLeft: Constraints.paddingX2,
                                paddingBottom: Constraints.paddingX2,
                                width: DesignConstraints.profileImageSize.width,
                                height: DesignConstraints.profileImageSize.height)
        
        addSubview(rightImageView)
        rightImageView.anchor(right: rightAnchor,
                              paddingRight: Constraints.paddingX2,
                              width: DesignConstraints.rightImageSize.width,
                              height: DesignConstraints.rightImageSize.height)
        rightImageView.anchorCenter(vertical: centerYAnchor)
        
        addSubview(userNameLabel)
        userNameLabel.anchor(left: profileImageView.rightAnchor,
                             right: rightImageView.leftAnchor,
                             paddingLeft: Constraints.paddingX2,
                             paddingRight: Constraints.basePadding)
        userNameLabel.anchorCenter(vertical: centerYAnchor)
        
        addSubview(separateView)
        separateView.anchor(top: profileImageView.bottomAnchor,
                            left: userNameLabel.leftAnchor,
                            bottom: bottomAnchor,
                            right: rightAnchor,
                            paddingTop: Constraints.paddingX2 - Constraints.lineHeight,
                            height: Constraints.lineHeight)
    }
    
    func configCell(with user: User) {
        
        userNameLabel.text = "@" + user.login
        
        if let url = user.avatarUrl {
            profileImageView.loadImage(urlString: url)
        }
    }
}
