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
        tabBar.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: tabBar.frame.size.height)
        tabBar.barTintColor = UIColor.black
        tabBar.tintColor = UIColor.white
        tabBar.items?[0].image = UIImage(imageLiteralResourceName: "aboutTabbarIcon")
        tabBar.items?[1].image = UIImage(imageLiteralResourceName: "recommendationsIcon")
        tabBar.items?[2].image = UIImage(imageLiteralResourceName: "castIcon")
        
        super.viewDidLayoutSubviews()
    }
}
