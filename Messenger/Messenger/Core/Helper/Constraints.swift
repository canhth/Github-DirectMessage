//
//  Constraint.swift
//  Messenger
//
//  Created by Canh Tran Wizeline on 3/10/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import UIKit

enum Constraints {
    static let lineHeight: CGFloat = 0.5
    
    static let basePadding: CGFloat = 8
    
    static let paddingX2 = basePadding * 2
    
    static let paddingX3 = basePadding * 3
    
    static var maxWidth: CGFloat {
        return UIScreen.main.bounds.width * 0.7
    }
}

enum Color {
    static let black = UIColor.black.withAlphaComponent(0.9)
    
    static let lightBackground = UIColor(red: 240 / 255, green: 239 / 255, blue: 244 / 255, alpha: 1)
}
