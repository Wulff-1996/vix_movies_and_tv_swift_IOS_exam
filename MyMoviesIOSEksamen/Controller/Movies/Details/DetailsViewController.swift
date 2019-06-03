//
//  DetailsViewController.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 14/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit
import DrawerView

class DetailsViewController: UIViewController
{
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mReleaseDate: UILabel!
    @IBOutlet weak var mRuntime: UILabel!
    @IBOutlet weak var mVoteCount: UILabel!
    
    
    let movieRepo = MovieRepository()
    
    var entertainment = Entertainment()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let url = URL(string: "\(entertainment.posterPath!)")!
        ImageService.getImage(withUrl: url)
        { image in
            self.poster.image = image
        }
        
        if entertainment.type == Constants.entertainmentTypes.MOVIES
        {
            movieRepo.getDetails(id: entertainment.id!)
            { (movie) in
                self.entertainment = movie
                global.entertainment = movie
                DispatchQueue.main.async{ self.updateView() }
                DispatchQueue.main.async{ self.setupDrawer() }
            }
        }
    }
    
    func updateView()
    {
        if self.entertainment.type == Constants.entertainmentTypes.MOVIES
        {
            let movie = entertainment as! Movie
            self.mVoteCount.text = "\(movie.voteAverage)"
            self.mTitle.text = movie.title
            self.mReleaseDate.text = movie.releaseDate
            self.mRuntime.text = "\(movie.runTime)"
        }
      
    }
    
    func setupDrawer()
    {
        let drawerViewController = self.storyboard!.instantiateViewController(withIdentifier: "DrawerViewController") as! CustomTabBarController
        let drawerView = self.addDrawerView(withViewController: drawerViewController)
        drawerView.isOpaque = true
        drawerView.snapPositions = [.collapsed, .open, .partiallyOpen]
        drawerView.insetAdjustmentBehavior = .automatic
        drawerView.backgroundEffect = UIBlurEffect(style: .extraLight)
        drawerView.cornerRadius = 0
        drawerView.collapsedHeight = 200
        drawerView.partiallyOpenHeight = 600
    }

    @IBAction func doBtnGoBack(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
       
    }
}
