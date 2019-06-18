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

protocol DiscoverDelegate
{
    func didSelectEntertainmentType(entertainmentType: String)
    func didSelectCategory(category: String)
}

class SlidingViewController: UIViewController
{
    var interactor: Interactor? = nil
    var discoverDelegate: DiscoverDelegate? = nil
    var entertainmentType: String? = nil
    
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
        if discoverDelegate != nil
        {
            let alertBov = AlertBox.createAlertBox(title: "Entertainment type", message: "Select an entertainment type.", options: Constants.getEntertainmentTypes())
            { (type) in
                self.discoverDelegate?.didSelectEntertainmentType(entertainmentType: type)
                self.dismiss(animated: true, completion: nil)
            }
            present(alertBov, animated: true, completion: nil)
        }
    }
    
    @IBAction func doBtnShowCategory(_ sender: Any)
    {
        if discoverDelegate != nil
        {
            var options = [String]()
            if entertainmentType == Constants.entertainmentTypes.MOVIES
            {
                options = Constants.getMovieCategories()
            }
            else
            {
                options = Constants.getTVCategories()
            }
            let alertBox = AlertBox.createAlertBox(title: "Category", message: "Select a category.", options: options)
            { (type) in
                self.discoverDelegate?.didSelectCategory(category: type)
                self.dismiss(animated: true, completion: nil)
            }
            self.present(alertBox, animated: true, completion: nil)
        }
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
