//
//  AboutViewController.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 21/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit

class TVAboutViewController: UIViewController
{
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var seasons: UILabel!
    @IBOutlet weak var episodes: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var genres: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        let tv = global.entertainment as! TV
        self.popularity?.text = "\(tv.popularity ?? 0)"
        self.seasons?.text = "\(tv.numberOfSeasons ?? 0)"
        self.episodes?.text = "\(tv.numberOfEpisodes ?? 0)"
        self.overview?.text = tv.overview
        self.genres?.text = StringConverter.convertStringArrayToString(input: tv.genres)
    }
}
