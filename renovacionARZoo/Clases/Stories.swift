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
    let image : UIImage
    let description : String
    
    init(image : UIImage, description : String){
        self.image = image
        self.description = description
    }
//    init(json : NSDictionary){
//        self.image = json["userName"] as! String
//        self.description = json["description"] as! String
//    }
}
