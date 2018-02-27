//
//  Elementos.swift
//  renovacionARZoo
//
//  Created by Kike on 21/2/18.
//  Copyright © 2018 Kike. All rights reserved.
//

import Foundation
import UIKit
class Elements{
    var name : String
    var image : UIImage
    var description : String
    var type : Int
    var x : Float
    var y : Float
    
    init(name : String, image: UIImage, description : String, type : Int, x : Float, y : Float){
        self.name = name
        self.image = image
        self.description = description
        self.x = x
        self.y = y
        self.type = type
    }
    
}
