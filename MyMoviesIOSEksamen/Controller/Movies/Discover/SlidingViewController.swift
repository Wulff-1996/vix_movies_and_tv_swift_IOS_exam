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
    
    @IBAction func closeBtnPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction public func doBtnSelectEntertainmentType(_ sender: Any)
    {
        let alertBov = AlertBox.createAlertBox(title: "Entertainment type", message: "Select an entertainment type.", options: Constants.getEntertainmentTypes())
        { (type) in
            if self.discoverViewController?.entertainmentType != type
            {
                //  update the view
                self.discoverViewController?.entertainmentType = type
                self.discoverViewController?.shouldBeUpdated.toggle()
                self.discoverViewController?.resetPage()
                self.discoverViewController?.resetMoviesAndTvs()
                self.discoverViewController?.category = Constants.movieCategories.POPULAR
                self.discoverViewController?.userDefault.set(type, forKey: "ENTERTAINMENT_TYPE")
                self.discoverViewController?.userDefault.set(Constants.movieCategories.POPULAR, forKey: "CATEGORY")

            }
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
            
            if self.discoverViewController?.category != type
            {
                //  update the origin view
                self.discoverViewController?.category = type
                self.discoverViewController?.shouldBeUpdated.toggle()
                self.discoverViewController?.resetPage()
                self.discoverViewController?.resetMoviesAndTvs()
                self.discoverViewController?.userDefault.set(type, forKey: "CATEGORY")
            }
            self.dismiss(animated: true, completion: nil)
        }
        self.present(alertBox, animated: true, completion: nil)
    }
    
    @IBAction func doBtnSignOut(_ sender: Any)
    {
        do
        {
            try Auth.auth().signOut()
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            let signInStoryboard =  UIStoryboard(name: "SignIn", bundle: nil)
            let startSigninVC = signInStoryboard.instantiateViewController(withIdentifier: "signInMenu")
            self.view.window?.rootViewController = startSigninVC
        }
        catch let err
        {
            print(err)
        }
    }
}
