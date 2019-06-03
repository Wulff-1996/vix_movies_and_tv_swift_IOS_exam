//
//  DiscoverRepository.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 16/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import Foundation

class MovieRepository
{
    private let API_ENDPOINT: String = "https://api.themoviedb.org/3/movie/"
    private let API_KEY: String = "api_key=81a6f060b362e563f6557d4c74ab2e27"
    private let LANGUANGE: String = "language=en-US"
    private let PAGE: String = "page="
    
    public func getAll(category: String, forPage: Int, completion: @escaping (_ movies: [Movie]) -> ())
    {
        let url = NSURL(string: "\(API_ENDPOINT)\(category)?\(API_KEY)&\(LANGUANGE)&\(PAGE)\(forPage)")
        DataTask.createDataTask(url: url! as URL)
        { (result) in
            if let data = result?.value(forKey: "results") as? NSArray
            {
                var movies = [Movie]()
                for m in data
                {
                    movies.append(ParseJson.parseToMovie(data: m as! NSDictionary))
                }
                completion(movies)
            }
        }
    }
    
    public func getDetails(id: Int, completion: @escaping (_ movie: Movie) -> ())
    {
        let url = NSURL(string: "\(API_ENDPOINT)\(id)?\(API_KEY)&\(LANGUANGE)")
        DataTask.createDataTask(url: url! as URL)
        { (result) in
            
            if let data = result
            {
                let movie = ParseJson.parseToMovieDetails(data: data)
                completion(movie)
            }
        }
    }
    
    public func getRecommendations(id: Int,forPage: Int,  completion: @escaping (_ movies: [Movie]) -> ())
    {
        let url = NSURL(string: "\(API_ENDPOINT)\(id)/similar?\(API_KEY)&\(LANGUANGE)&(PAGE)\(forPage)")
        DataTask.createDataTask(url: url! as URL)
        { (result) in
            if let data = result?.value(forKey: "results") as? NSArray
            {
                var movies = [Movie]()
                for m in data
                {
                    movies.append(ParseJson.parseToMovie(data: m as! NSDictionary))
                }
                completion(movies)
            }
        }
    }
}
