//
//  StringConverter.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 08/06/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import Foundation

class StringConverter
{
    public static func convertDoubleToString(input: Double?) -> String
    {
        var result = "n/a"
        if let data = input
        {
            result = "\(data)"
        }
        return result
    }
    
    public static func convertIntToString(input: Int?) -> String
    {
        var result = "n/a"
        if let data = input
        {
            result = "\(data)"
        }
        return result
    }
    
    public static func convertStringArrayToString(input: [String]?) -> String
    {
        var result = ""
        if let data = input
        {
            for value in data
            {
                result += value + "\n"
            }
        }
        else
        {
            result = "n/a"
        }
        return result
    }
    
    public static func convertIntArrayToString(input: [Int]?) -> String
    {
        var result = ""
        if let data = input
        {
            for value in data
            {
                result += "\(value) \n"
            }
        }
        else
        {
            result = "n/a"
        }
        return result
    }
}
