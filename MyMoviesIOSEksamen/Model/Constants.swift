//
//  Constants.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 16/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import Foundation

class Constants
{
    struct entertainmentTypes
    {
        static let MOVIES = "movies"
        static let TV = "tv"
    }
    struct movieCategories
    {
        static let POPULAR = "popular"
        static let UPCOMING = "upcoming"
        static let TOP_RATED = "top_rated"
        static let NOW_PLAYING = "now_playing"
    }
    struct tvCategories
    {
        static let POPULAR = "popular"
        static let TOP_RATED = "top_rated"
        static let ON_AIR = "on_the_air"
        static let AIRING_TODAY = "airing_today"
    }
    
    public static func getEntertainmentTypes() -> [String]
    {
        var items = [String]()
        items.append(entertainmentTypes.MOVIES)
        items.append(entertainmentTypes.TV)
        return items
    }
    
    public static func getMovieCategories() -> [String]
    {
        var items = [String]()
        items.append(movieCategories.POPULAR)
         items.append(movieCategories.UPCOMING)
         items.append(movieCategories.NOW_PLAYING)
         items.append(movieCategories.TOP_RATED)
        return items
    }
    
    public static func getTVCategories() -> [String]
    {
        var items = [String]()
        items.append(tvCategories.POPULAR)
        items.append(tvCategories.ON_AIR)
        items.append(tvCategories.AIRING_TODAY)
        items.append(tvCategories.TOP_RATED)
        return items
    }
}
