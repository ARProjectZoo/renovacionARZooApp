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
var arrayStories : [Story] = []
var arrayElements : [Elements] = []
var arrayAnimals : [Animals] = []

var dictionaryContientes = [
    1 : "Africa",
    2 : "Asia",
    3 : "America del Norte",
    4 : "America del Sur",
    5 : "America Central y Caribe",
    6 : "Europa",
    7 : "Oceanía"
]

var arrayContinentes = [
    Continents(name: "Africa", image: #imageLiteral(resourceName: "mapa_africa_continentes")),
    Continents(name: "Asia", image: #imageLiteral(resourceName: "mapa_asia_continentes")),
    Continents(name: "America del Norte", image: #imageLiteral(resourceName: "mapa_america_norte")),
    Continents(name: "America del Sur", image: #imageLiteral(resourceName: "mapa_america_sur")),
    Continents(name: "America Central y Caribe", image: #imageLiteral(resourceName: "mapa_america_central")),
    Continents(name: "Europa", image: #imageLiteral(resourceName: "mapa_europa_continentes")),
    Continents(name: "Oceanía", image: #imageLiteral(resourceName: "mapa_oceania_continentes")),
]
func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
{
    DispatchQueue.main.async {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
