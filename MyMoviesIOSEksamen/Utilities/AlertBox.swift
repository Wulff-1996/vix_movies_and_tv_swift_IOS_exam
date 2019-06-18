//
//  AlertBox.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 09/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import Foundation
import UIKit

class AlertBox{
    
    public static func createAlertBox(title: String, message: String) -> UIAlertController
    {
        
        let alertBox = UIAlertController()
        alertBox.title = title
        alertBox.message = message
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertBox.addAction(cancelAction)
        return alertBox
    }
        
    public static func createAlertBox(title: String, message: String, options: [String], completion: @escaping (_ type: String)->()) -> UIAlertController
    {
        let alertBox = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for type in options
        {
            alertBox.addAction(UIAlertAction(title: type, style: .default, handler:
                { (action: UIAlertAction!) in
                completion(type)
            }))
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alertBox.addAction(cancelAction)
        return alertBox
    }
    
    public static func createAlertBoxForVideos(title: String, message: String, videos: [Video], completion: @escaping (_ youTubeId: String)->()) -> UIAlertController
    {
        let alertBox = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for video in videos
        {
            alertBox.addAction(UIAlertAction(title: video.name!, style: .default, handler:
                { (action: UIAlertAction!) in
                    completion(video.youTuebeId!)
            }))
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alertBox.addAction(cancelAction)
        return alertBox
    }
}
