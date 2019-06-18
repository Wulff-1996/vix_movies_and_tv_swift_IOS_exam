//
//  Video.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 11/06/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import Foundation
import ObjectMapper

class Video: Mappable
{
    var id: String?
    var youTuebeId: String? 
    var name: String?
    var site: String?
    var size: Int?
    var type: String?
    
    required init?(map: Map)
    {
        if map.JSON["id"] == nil
        {
            return nil
        }
    }
    
    func mapping(map: Map)
    {
        id <- map["id"]
        youTuebeId <- map["key"]
        name <- map["name"]
        site <- map["site"]
        type <- map["type"]
    }
}
