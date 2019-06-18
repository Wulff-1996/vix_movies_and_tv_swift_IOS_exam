//
//  CustomTabBarController.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 21/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        tabBar.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 50)
        tabBar.barTintColor = UIColor.black
        tabBar.tintColor = UIColor.white
    }
}
