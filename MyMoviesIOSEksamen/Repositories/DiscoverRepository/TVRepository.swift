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
}
