//
//  Animals.swift
//  renovacionARZoo
//
//  Created by Kike on 21/2/18.
//  Copyright © 2018 Kike. All rights reserved.
//

import Foundation
import UIKit

class Animals :  NSObject {
    var name : String
    var descriptionAnimal : String
    var continent : Int
    var image : UIImage
    var x : Float
    var y : Float
    var id : Int
    var urlImage : String
    
     init(name : String, descriptionAnimal : String, continent : Int, image: UIImage){
        self.id = 0
        self.name = name
        self.continent = continent
        self.descriptionAnimal = descriptionAnimal
        self.x = 0
        self.y = 0
        self.image = image
        self.urlImage = ""
    }
    
}
