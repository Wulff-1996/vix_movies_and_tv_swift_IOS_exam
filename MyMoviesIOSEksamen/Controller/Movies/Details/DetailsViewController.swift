//
//  DetailsViewController.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 14/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit
import DrawerView
import YoutubePlayer_in_WKWebView


class DetailsViewController: UIViewController
{
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mReleaseDate: UILabel!
    @IBOutlet weak var mRuntime: UILabel!
    @IBOutlet weak var mVoteCount: UILabel!
    
    @IBOutlet weak var videoView: WKYTPlayerView!
    
    let movieRepo = MovieRepository()
    let tvRepo = TVRepository()
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
        else if entertainment.type == Constants.entertainmentTypes.TV
        {
            tvRepo.getTVDetails(tvId: entertainment.id!)
            { (tv) in
                self.entertainment = tv
                global.entertainment = tv
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
            self.mVoteCount.text = StringConverter.convertDoubleToString(input: movie.voteAverage)
            self.mTitle.text = movie.title
            self.mReleaseDate.text = movie.releaseDate
            self.mRuntime.text = StringConverter.convertIntToString(input: movie.runTime)
        }
        else if self.entertainment.type == Constants.entertainmentTypes.TV
        {
            let tv = entertainment as! TV
            self.mVoteCount.text = StringConverter.convertDoubleToString(input: tv.voteAverage)
            self.mTitle.text = tv.name
            self.mReleaseDate.text = tv.firstAirDate
            self.mRuntime.text = StringConverter.convertIntArrayToString(input: tv.episodeRunTime)
        }
    }
    
    func setupDrawer()
    {
        var drawerIdentifier: String?
        var thirdIcon: String?
        var thirdTitle: String?
        if entertainment.type == Constants.entertainmentTypes.MOVIES
        {
            drawerIdentifier = "MoviesDrawerViewController"
            thirdIcon = "castIcon"
            thirdTitle = "cast"
        }
        else if entertainment.type == Constants.entertainmentTypes.TV
        {
            drawerIdentifier = "TVsDrawerViewController"
            thirdIcon = "list_icon"
            thirdTitle = "seasons"
        }
        
        let drawerViewController = self.storyboard!.instantiateViewController(withIdentifier: drawerIdentifier!) as! CustomTabBarController
        
        drawerViewController.firstIcon = "aboutTabbarIcon"
        drawerViewController.secondIcon = "recommendationsIcon"
        drawerViewController.thirdIcon = thirdIcon!
        drawerViewController.firstTitle = "about"
        drawerViewController.secondTitle = "similir"
        drawerViewController.thirdTitle = thirdTitle!
        
        let drawerView = self.addDrawerView(withViewController: drawerViewController)
        drawerView.isOpaque = true
        drawerView.snapPositions = [.collapsed, .partiallyOpen, .open]
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
    
    @IBAction func showVideo(_ sender: Any)
    {
        if entertainment.type == Constants.entertainmentTypes.MOVIES
        {
            movieRepo.getMovieVideos(movieId: entertainment.id!)
            { (videos) in
                let alertBox = AlertBox.createAlertBoxForVideos(title: "Videos", message: "Select a video to play.", videos: videos, completion:
                { (key) in
                    self.videoView.isHidden = false
                    self.videoView.load(withVideoId: key)
                })
                self.present(alertBox, animated: true, completion: nil)
            }
        }
        else if entertainment.type == Constants.entertainmentTypes.TV
        {
            tvRepo.getTVVideos(tvId: entertainment.id!)
            { (videos) in
                let alertBox = AlertBox.createAlertBoxForVideos(title: "Videos", message: "Select a video to play.", videos: videos, completion:
                { (key) in
                    self.videoView.isHidden = false
                    self.videoView.load(withVideoId: key)
                })
                self.present(alertBox, animated: true, completion: nil)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch: UITouch? = touches.first
        if touch?.view != self.videoView
        {
            self.videoView.isHidden = true
        }
    }
}
