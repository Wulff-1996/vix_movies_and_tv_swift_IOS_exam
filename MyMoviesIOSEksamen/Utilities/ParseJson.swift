//
//  ParseJson.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 16/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import Foundation

class ParseJson
{
    public static func parseToMovie(data: NSDictionary) -> Movie
    {
        let movie = Movie()
        movie.id = data.value(forKey: "id") as! Int
        movie.title = data.value(forKey: "title") as! String
        movie.releaseDate = data.value(forKey: "release_date") as! String
        movie.overview = data.value(forKey: "overview") as! String
        movie.posterPath = "https://image.tmdb.org/t/p/w500\(data.value(forKey: "poster_path") as? String ?? String())"
        movie.voteCount = data.value(forKey: "vote_count") as! Int
        movie.voteAverage = data.value(forKey: "vote_average") as! Double
        return movie
    }
    
    public static func parseToMovieDetails(data: NSDictionary) -> Movie
    {
        let movie = Movie()
        movie.id = (data.value(forKey: "id") as! Int)
        movie.title = (data.value(forKey: "title") as! String)
        movie.releaseDate = (data.value(forKey: "release_date") as! String)
        movie.overview = (data.value(forKey: "overview") as! String)
        movie.posterPath = "https://image.tmdb.org/t/p/w500\(data.value(forKey: "poster_path") as? String ?? String())"
        movie.voteCount = data.value(forKey: "vote_count") as? Int
        movie.voteAverage = data.value(forKey: "vote_average") as? Double ?? 0

        let genres = data.value(forKey: "genres") as! NSArray
        for genre in genres
        {
            let genre = genre as! NSDictionary
            movie.genres?.append(genre.value(forKey: "name") as! String)
        }
        if let runtime = data.value(forKey: "runtime") as? Int
        {
            movie.runTime = runtime
        }
        movie.popularity = (data.value(forKey: "popularity") as! Double)
        return movie
    }
    
    public static func parseToTV(data: NSDictionary) -> TV
    {
        let tv = TV()
        tv.id = data.value(forKey: "id") as! Int
        tv.name = data.value(forKey: "name") as! String
        tv.firstAirDate = data.value(forKey: "first_air_date") as! String
        tv.overview = data.value(forKey: "overview") as! String
        tv.posterPath = "https://image.tmdb.org/t/p/w500\(data.value(forKey: "poster_path") as? String ?? String())"
        tv.voteCount = data.value(forKey: "vote_count") as! Int
        tv.voteAverage = data.value(forKey: "vote_average") as! Double
        return tv
    }

}
