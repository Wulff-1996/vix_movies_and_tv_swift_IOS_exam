//
//  DataTask.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 16/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import Foundation

class DataTask: URLSession
{
    public static func createDataTask(url: URL, completion: @escaping (_ json: NSDictionary?)-> ())
    {
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler:
            {(data, response, error) -> Void in
                if error == nil
                {
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                    {
                        completion(jsonObj)
                    }
                }
        }).resume()
    }
}
