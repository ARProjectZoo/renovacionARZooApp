//
//  ViewController.swift
//  miloginKit
//
//  Created by Kike on 6/2/18.
//  Copyright © 2018 Kike. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class LoginViewController: UIViewController {
    
    lazy var loginCoordinator: MiLoginCoordinator = {
        return MiLoginCoordinator(rootViewController: self)
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let token = UserDefaults.standard.string(forKey: "token"){
            let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            //Position Activity Indicator in the center of the main view
            myActivityIndicator.center = view.center

            //If needed, yo can prevent activity Idicantor from hiing ehen stopAnimating() is called
            myActivityIndicator.hidesWhenStopped = false
            myActivityIndicator.startAnimating()
            view.addSubview(myActivityIndicator)
            DispatchQueue.main.async {
                Request(view: self, myActivityIndicator: myActivityIndicator, mainCoordinator: self.loginCoordinator).getAnimalJson()
                let storyboard: UIStoryboard =   UIStoryboard (name: "Main", bundle: nil)
                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "mainAPP") as UIViewController
                self.present(vc ,animated: true, completion: nil )
            }



        }else{
            loginCoordinator.start()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

