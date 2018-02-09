//
//  ViewController.swift
//  miloginKit
//
//  Created by Kike on 6/2/18.
//  Copyright © 2018 Kike. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class ViewController: UIViewController {
    
    lazy var loginCoordinator: MiLoginCoordinator = {
        return MiLoginCoordinator(rootViewController: self)
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        loginCoordinator.start()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

