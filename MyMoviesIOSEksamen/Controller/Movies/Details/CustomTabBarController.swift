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
    var firstIcon: String?
    var secondIcon: String?
    var thirdIcon: String?
    var firstTitle: String?
    var secondTitle: String?
    var thirdTitle: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews()
    {
        tabBar.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: tabBar.frame.size.height)
        tabBar.barTintColor = UIColor.black
        tabBar.tintColor = UIColor.white
        tabBar.items?[0].title = firstTitle
        tabBar.items?[1].title = secondTitle
        tabBar.items?[2].title = thirdTitle
        tabBar.items?[0].image = UIImage(imageLiteralResourceName: firstIcon!)
        tabBar.items?[1].image = UIImage(imageLiteralResourceName: secondIcon!)
        tabBar.items?[2].image = UIImage(imageLiteralResourceName: thirdIcon!)
        
        super.viewDidLayoutSubviews()
    }
}
