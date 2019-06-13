//
//  VideoViewController.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 11/06/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class VideoViewController: UIViewController
{

    @IBOutlet weak var videoView: WKYTPlayerView!
    var youTubeVideoId: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        videoView.load(withVideoId: "\(self.youTubeVideoId ?? "Mc0TMWYTU_k")")
    }
}
