//
//  CustomTabBar.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 13/06/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit

class CustomTabBar : UITabBar {
    @IBInspectable var height: CGFloat = 0.0
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            sizeThatFits.height = height
        }
        return sizeThatFits
    }
}
