//
//  MovieCell.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 14/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit

class Entertak: UICollectionViewCell
{
    
    @IBOutlet weak var posterImageview: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    public func configure (image: UIImage)
    {
        posterImageview.image = image
    }
}
