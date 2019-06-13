//
//  SlidingViewController.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 17/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit
import NavigationDrawer
import Firebase

class SlidingViewController: UIViewController
{
    var interactor: Interactor? = nil
    var discoverViewController: DiscoverViewController?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //Handle Gesture
    @IBAction func handleGesture(sender: UIPanGestureRecognizer)
    {
        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .Left)
        
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor)
        {
                self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction public func doBtnSelectEntertainmentType(_ sender: Any)
    {
        let alertBov = AlertBox.createAlertBox(title: "Entertainment type", message: "Select an entertainment type.", options: Constants.getEntertainmentTypes())
        { (type) in
            //  update the view
            self.discoverViewController?.entertainmentType = type
            self.discoverViewController?.shouldBeUpdated.toggle()
            self.discoverViewController?.resetPage()
            self.discoverViewController?.resetMoviesAndTvs()
            self.discoverViewController?.category = Constants.movieCategories.POPULAR
            self.dismiss(animated: true, completion: nil)
        }
        present(alertBov, animated: true, completion: nil)
    }
    
    @IBAction func doBtnShowCategory(_ sender: Any)
    {
        var options = [String]()
        if self.discoverViewController?.entertainmentType == Constants.entertainmentTypes.MOVIES
        {
            options = Constants.getMovieCategories()
        }
        else
        {
            options = Constants.getTVCategories()
        }
        let alertBox = AlertBox.createAlertBox(title: "Category", message: "Select a category.", options: options)
        { (type) in
            //  update the origin view
            self.discoverViewController?.category = type
            self.discoverViewController?.shouldBeUpdated.toggle()
            self.discoverViewController?.resetPage()
            self.discoverViewController?.resetMoviesAndTvs()
            self.dismiss(animated: true, completion: nil)
        }
        self.present(alertBox, animated: true, completion: nil)
    }
    
    @IBAction func doBtnSignOut(_ sender: Any)
    {
        do
        {
            try Auth.auth().signOut()
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        }
        catch let err
        {
            print(err)
        }
    }
}
