//
//  Movie.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 10/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//
import UIKit

class Movie: Entertainment
{
    var title: String?
    var releaseDate: String?
    var popularity: Double?
    var genres: [String]?
    var runTime: Int?
    
    override init()
    {
        super.init()
        self.type = Constants.entertainmentTypes.MOVIES
    }
}
