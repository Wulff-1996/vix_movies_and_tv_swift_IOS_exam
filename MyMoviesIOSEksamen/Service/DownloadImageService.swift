//
//  DownloadImageService.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 14/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit

class ImageService
{
    static let cache = NSCache<NSString, UIImage>()
    
    static func downloadImage(withUrl url: URL, completion: @escaping (_ image: UIImage?)-> ())
    {
        let dataTask = URLSession.shared.dataTask(with: url)
        {
            data, responseUrl, error in
            
            var downloadedImage: UIImage?
            
            if let data = data
            {
                downloadedImage = UIImage(data: data)
            }
            
            if downloadedImage != nil
            {
                cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async{ completion(downloadedImage) }
        }
        dataTask.resume()
    }
    
    static func getImage(withUrl url: URL, completion: @escaping (_ image: UIImage?) -> ())
    {
        if let image = cache.object(forKey: url.absoluteString as NSString)
        {
            completion(image)
        }
        else
        {
            downloadImage(withUrl: url, completion: completion)
        }
    }
}

