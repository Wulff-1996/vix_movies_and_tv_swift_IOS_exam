//
//  TV.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 16/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import Foundation

class TV: Entertainment
{
    var name: String?
    var firstAirDate: String?
    var genres: [String]?
    var popularity: Double?
    var numberOfSeasons: Int?
    var numberOfEpisodes: Int?
    var episodeRunTime: [Int]?
    var seasons: [Season]?
    
    override init()
    {
        super.init()
        self.type = Constants.entertainmentTypes.TV
    }
}
