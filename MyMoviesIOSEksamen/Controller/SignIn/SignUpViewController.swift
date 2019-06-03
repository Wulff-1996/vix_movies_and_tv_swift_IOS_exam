//
//  SignUpViewController.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 08/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPassword2: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doBtnSignUp(_ sender: Any)
    {
        if let email = tfEmail.text, let password = tfPassword.text, let password2 = tfPassword2.text
        {
            if password == password2
            {
                Auth.auth().createUser(withEmail: email, password: password)
                { (user, error) in
                    if error != nil
                    {
                        let alertBox = AlertBox.createAlertBox(title: "Invalid user data", message: error!.localizedDescription)
                        self.present(alertBox, animated: true, completion: nil)
                    }
                    else
                    {
                        //  go to next viewcontroller
                        self.performSegue(withIdentifier: "showMovies", sender: nil)
                    }
                }
            }
            else
            {
                //  passwords do not match
                let alertBox = AlertBox.createAlertBox(title: "Passwords invalid.", message: "passwords do not match.")
                self.present(alertBox, animated: true, completion: nil)
            }
            
        }
    }
    
    @IBAction func doBtnGoBack(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
