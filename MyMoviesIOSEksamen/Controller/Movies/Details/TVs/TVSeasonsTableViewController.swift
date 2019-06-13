//
//  CastsTableViewController.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 08/06/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit

class TVSeasonsTableViewController: UITableViewController
{
    var seasons = [Season]()
    let tvRepo = TVRepository()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let tv = global.entertainment as! TV
        self.seasons = tv.seasons!
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
        return self.seasons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SeasonCell
        let season = self.seasons[indexPath.row]
        // Configure the cell...
        cell.name.text = season.name
        cell.overview.text = season.overview
        
        if let path = season.posterPath
        {
            if !path.isEmpty
            {
                let url = URL(string: "\(path)")!
                ImageService.getImage(withUrl: url)
                { image in
                    cell.poster.image = image
                }
            }
            else
            {
                cell.poster.image = UIImage(named: "placeholderimage.jpg")
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
}
