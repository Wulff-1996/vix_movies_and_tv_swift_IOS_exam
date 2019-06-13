//
//  SeasonCell.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 13/06/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit

class SeasonCell: UITableViewCell
{
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var overview: UITextView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    public func configure (image: UIImage, name: String, overview: String)
    {
        self.poster.image = image
        self.name.text = name
        self.overview.text = overview
    }
}
