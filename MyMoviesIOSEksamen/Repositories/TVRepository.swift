//
//  TVRepository.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 16/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import Foundation

class TVRepository
{
    private let API_ENDPOINT: String = "https://api.themoviedb.org/3/tv/"
    private let API_KEY: String = "api_key=81a6f060b362e563f6557d4c74ab2e27"
    private let LANGUANGE: String = "language=en-US"
    private let PAGE: String = "page="
    
    public func getAll(category: String, forPage: Int, completion: @escaping (_ tvs: [TV]) -> ())
    {
        let url = NSURL(string: "\(API_ENDPOINT)\(category)?\(API_KEY)&\(LANGUANGE)&\(PAGE)\(forPage)")
        DataTask.createDataTask(url: url! as URL)
        { (result) in
            if let tvShows = result?.value(forKey: "results") as? NSArray
            {
                var tvs = [TV]()
                for tvShow in tvShows
                {
                    tvs.append(ParseJson.parseToTV(data: tvShow as! NSDictionary))
                }
                completion(tvs)
            }
        }
    }
    
    public func getTVDetails(tvId: Int, completion: @escaping (_ tv: TV) -> ())
    {
        let url = NSURL(string: "\(API_ENDPOINT)\(tvId)?\(API_KEY)&\(LANGUANGE)")
        DataTask.createDataTask(url: url! as URL)
        { (result) in
            if let data = result
            {
                let tv = ParseJson.parseToTVDetails(data: data)
                completion(tv)
            }
        }
    }
    
    public func getRecommendations(id: Int,forPage: Int,  completion: @escaping (_ tvs: [TV]) -> ())
    {
        let url = NSURL(string: "\(API_ENDPOINT)\(id)/similar?\(API_KEY)&\(LANGUANGE)&\(PAGE)\(forPage)")
        DataTask.createDataTask(url: url! as URL)
        { (result) in
            if let data = result?.value(forKey: "results") as? NSArray
            {
                var tvs = [TV]()
                for tv in data
                {
                    tvs.append(ParseJson.parseToTV(data: tv as! NSDictionary))
                }
                completion(tvs)
            }
        }
    }
    
    public func getTVVideos(tvId: Int, completion: @escaping (_ videos: [Video]) -> ())
    {
        let url = NSURL(string: "\(API_ENDPOINT)\(tvId)/videos?\(API_KEY)&\(LANGUANGE)")
        DataTask.createDataTask(url: url! as URL)
        { (result) in
            if let data = result?.value(forKey: "results") as? NSArray
            {
                var videos = [Video]()
                for entry in data
                {
                    if let video = Video(JSON: entry as! [String: Any])
                    {
                        videos.append(video)
                    }
                }
                completion(videos)
            }
        }
    }
}
