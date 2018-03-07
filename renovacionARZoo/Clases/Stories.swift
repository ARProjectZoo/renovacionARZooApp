//
//  Stories.swift
//  renovacionARZoo
//
//  Created by Kike on 12/2/18.
//  Copyright © 2018 Kike. All rights reserved.
//

import Foundation
import UIKit
class Story{
    var image : UIImage
    let comment : String
    let urlImage : String
    let date : String
    
    
    init(json : NSDictionary){
        self.comment = json["comment"] as! String
        self.image = UIImage()
        self.urlImage = json["photo"] as! String
        self.date = json["date"] as! String
    }
//    init(json : NSDictionary){
//        self.image = json["userName"] as! String
//        self.description = json["description"] as! String
//    }
}
