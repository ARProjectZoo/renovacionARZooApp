//
//  appTools.swift
//  miloginKit
//
//  Created by Kike on 7/2/18.
//  Copyright © 2018 Kike. All rights reserved.
//

import Foundation
import UIKit
var userLogged : User!
func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
{
    DispatchQueue.main.async {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
