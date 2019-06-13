//
//  CastCell.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 08/06/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit

class CastCell: UITableViewCell
{
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var charactorName: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    public func configure (image: UIImage, nameActor: String, nameCharactor: String)
    {
        posterImage.image = image
        actorName.text = nameActor
        charactorName.text = nameCharactor
    }
}
