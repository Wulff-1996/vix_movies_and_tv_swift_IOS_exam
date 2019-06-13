//
//  AboutViewController.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 21/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit

class MoviesAboutViewController: UIViewController
{
    
  
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var genres: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let movie = global.entertainment as! Movie
        self.popularity?.text = "\(movie.popularity ?? 0)"
        self.overview?.text = movie.overview
        self.genres?.text = StringConverter.convertStringArrayToString(input: movie.genres)
    }
}
