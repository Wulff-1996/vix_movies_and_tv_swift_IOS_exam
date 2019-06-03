//
//  AboutViewController.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 21/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController
{
    
    @IBOutlet var popularity: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var genres: UILabel!
    
    var movie = Movie()
    var tv = TV()
    var entertainment = Entertainment()
    
    let movieRepo = MovieRepository()
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.entertainment = global.entertainment
        
        if entertainment.type == Constants.entertainmentTypes.MOVIES
        {
            self.movie = entertainment as! Movie
            self.popularity?.text = "\(movie.popularity)"
            self.overview?.text = movie.overview
        }
    }
}
