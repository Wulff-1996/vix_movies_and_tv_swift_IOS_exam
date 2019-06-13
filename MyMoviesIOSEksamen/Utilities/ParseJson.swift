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
        movie.id = (data.value(forKey: "id") as! Int)
        movie.title = (data.value(forKey: "title") as! String)
        movie.releaseDate = (data.value(forKey: "release_date") as! String)
        movie.overview = (data.value(forKey: "overview") as! String)
        movie.posterPath = "https://image.tmdb.org/t/p/w500\(data.value(forKey: "poster_path") as? String ?? String())"
        movie.voteCount = (data.value(forKey: "vote_count") as! Int)
        movie.voteAverage = (data.value(forKey: "vote_average") as! Double)
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

        movie.genres = []
        let genres = data.value(forKey: "genres") as! NSArray
        for g in genres
        {
            let genre = g as! NSDictionary
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
        tv.id = data.value(forKey: "id") as? Int
        tv.name = data.value(forKey: "name") as? String
        tv.firstAirDate = data.value(forKey: "first_air_date") as? String
        tv.overview = data.value(forKey: "overview") as? String
        tv.posterPath = "https://image.tmdb.org/t/p/w500\(data.value(forKey: "poster_path") as? String ?? String())"
        tv.voteCount = data.value(forKey: "vote_count") as? Int
        tv.voteAverage = data.value(forKey: "vote_average") as? Double
        return tv
    }
    
    public static func parseToCast(data: NSDictionary) -> Cast
    {
        let cast = Cast()
        cast.character = data.value(forKey: "character") as? String ?? "n/a"
        cast.name = data.value(forKey: "name") as? String ?? "n/a"
        if let castId = data.value(forKey: "profile_path") as? String {
            cast.profilePath = "https://image.tmdb.org/t/p/w500\(castId)"
        }
        return cast
    }
    
    public static func parseToVideo(data: NSDictionary) -> Video
    {
        let video = Video()
        video.youTuebeId = data.value(forKey: "key") as? String
        video.name = data.value(forKey: "name") as? String ?? "n/a"
        video.site = data.value(forKey: "site") as? String ?? "n/a"
        video.size = data.value(forKey: "size") as? Int ?? 0
        return video
    }
    
    public static func parseToTVDetails(data: NSDictionary) -> TV
    {
        let tv = TV()
        tv.id = data.value(forKey: "id") as? Int
        tv.name = data.value(forKey: "name") as? String
        tv.firstAirDate = data.value(forKey: "first_air_date") as? String
        tv.overview = data.value(forKey: "overview") as? String
        tv.posterPath = "https://image.tmdb.org/t/p/w500\(data.value(forKey: "poster_path") as? String ?? String())"
        tv.voteCount = data.value(forKey: "vote_count") as? Int
        tv.voteAverage = data.value(forKey: "vote_average") as? Double
        tv.genres = []
        let genres = data.value(forKey: "genres") as! NSArray
        for g in genres
        {
            let genre = g as! NSDictionary
            tv.genres?.append(genre.value(forKey: "name") as! String)
        }
        tv.popularity = data.value(forKey: "popularity") as? Double
        tv.episodeRunTime = []
        let runtimes = data.value(forKey: "episode_run_time") as! NSArray
        for r in runtimes
        {
            tv.episodeRunTime?.append(r as! Int)
        }
        tv.seasons = [Season]()
        let seasons = data.value(forKey: "seasons") as! NSArray
        for season in seasons
        {
            tv.seasons?.append(ParseJson.parseToSeason(data: season as! NSDictionary))
        }
        tv.numberOfSeasons = data.value(forKey: "number_of_seasons") as? Int ?? 0
        tv.numberOfEpisodes = data.value(forKey: "number_of_episodes") as? Int ?? 0
        return tv
    }
    
    public static func parseToSeason(data: NSDictionary) -> Season
    {
        let season = Season()
        season.name = data.value(forKey: "name") as? String ?? "n/a"
        season.overview = data.value(forKey: "overview") as? String? ?? "n/a"
        season.airDate = data.value(forKey: "air_date") as? String ?? "n/a"
        season.episodes = data.value(forKey: "episode_count") as? Int
        season.posterPath = "https://image.tmdb.org/t/p/w500\(data.value(forKey: "poster_path") as? String ?? String())"
        return season
    }
   
}
