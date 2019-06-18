//
//  SignInViewController.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 08/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class SignInViewController: UIViewController
{
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doBtnSignInEmail(_ sender: UIButton)
    {
        if Auth.auth().currentUser == nil
        {
            if let email = tfEmail.text, let password = tfPassword.text
            {
                Auth.auth().signIn(withEmail: email, password: password)
                { (user,error ) in
                    if error != nil
                    {
                        let alertBox = AlertBox.createAlertBox(title: "Account not recognized", message: error!.localizedDescription)
                        self.present(alertBox, animated: true, completion: nil)
                    }
                    else
                    {
                        //  present next viewcontroller
                        self.performSegue(withIdentifier: "showMovies", sender: nil)
                    }
                
                }
            }
        }
        else
        {
            // a user is already signed in
            let alertBox = AlertBox.createAlertBox(title: "Already signed in", message: "\(Auth.auth().currentUser!.email ?? "user") is already signed in.")
            self.present(alertBox, animated: true, completion: nil)
        }
    }
    
    @IBAction func doBtnSignInFacebook(_ sender: Any)
    {
        let LoginManager = FBSDKLoginManager()
        LoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self)
        { (result, error) in
            if let error = error
            {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            guard let accessToken = FBSDKAccessToken.current()
                else
            {
                print("Failed to get access token")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            Auth.auth().signInAndRetrieveData(with: credential)
            { (user, error) in
                if let error = error
                {
                    let alertBox = AlertBox.createAlertBox(title: "Login Error", message: error.localizedDescription)
                    self.present(alertBox, animated: true, completion: nil)
                    return
                }
                self.performSegue(withIdentifier: "showMovies", sender: nil)
            }
        }
    }
    
    @IBAction func doBtnGoBack(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}
