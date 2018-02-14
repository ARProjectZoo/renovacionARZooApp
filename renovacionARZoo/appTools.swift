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
var arrayStories = [Story(image: #imageLiteral(resourceName: "gradientBG"), description: "PRIMERA HISTORIA DE LA APP"),Story( image: #imageLiteral(resourceName: "fotoperfil"), description: "Segunda historia de la app"),Story(image: #imageLiteral(resourceName: "tarjeta zoo2"), description: "PRIMERA HISTORIA DE LA APP"),Story(image: #imageLiteral(resourceName: "fondozoo"), description: "PRIMERA HISTORIA DE LA APP"),Story(image: #imageLiteral(resourceName: "tarjetazoo"), description: "PRIMERA HISTORIA DE LA APP")]
func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
{
    DispatchQueue.main.async {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
