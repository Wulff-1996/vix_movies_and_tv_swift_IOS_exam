//
//  CastsTableViewController.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 08/06/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit

class MoviesCastsTableViewController: UITableViewController
{
    private var casts = [Cast]()
    //  repositories
    let movieRepo = MovieRepository()
    let tvRepo = TVRepository()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData()
    {
        if global.entertainment.type == Constants.entertainmentTypes.MOVIES
        {
            self.movieRepo.getMovieCredits(movieId: global.entertainment.id!)
            { (casts) in
                self.casts.append(contentsOf: casts)
                DispatchQueue.main.async{ self.reloadData() }
            }
        }
        else
        {
        }
    }
    
    func reloadData()
    {
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.casts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CastCell
        let cast = self.casts[indexPath.row]
        // Configure the cell...
        cell.actorName.text = cast.name
        cell.charactorName.text = cast.character
        
        if let path = cast.profilePath
        {
            if !path.isEmpty
            {
                let url = URL(string: "\(path)")!
                ImageService.getImage(withUrl: url)
                { image in
                    cell.posterImage.image = image
                }
            }
            else
            {
                cell.posterImage.image = UIImage(named: "placeholderimage.jpg")
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
}
