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
    var urlImage : String
    var description : String
    var type : Int
    var x : Float
    var y : Float
    
    
    
    init(json : NSDictionary){
        self.name = json["name"] as! String
        self.description = json["description"] as! String
        self.type = Int((json["id_type"] as! NSString).doubleValue)
        self.image = UIImage()
        self.x = Float((json["x"] as! NSString).doubleValue)
        self.y = Float((json["y"] as! NSString).doubleValue)
        self.urlImage = json["photo"] as! String
    }
}
