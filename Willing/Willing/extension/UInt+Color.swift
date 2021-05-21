//
//  UInt+Color.swift
//  Willing
//
//  Created by Kim on 2021/04/10.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import Foundation
import UIKit

extension UInt {
    //
    func uiColorFromRGB() -> UIColor {
        let rgbValue = self
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // computed property(<-> stored property)
    var uiColor: UIColor {
        return UIColor(
            red: CGFloat((self & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((self & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(self & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    var cgColor: CGColor {
        return uiColor.cgColor
    }
}
