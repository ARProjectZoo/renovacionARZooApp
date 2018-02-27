//
//  arrayAnimals.swift
//  renovacionARZoo
//
//  Created by Kike on 21/2/18.
//  Copyright © 2018 Kike. All rights reserved.
//

import Foundation
import UIKit
class obcjectAnimalsArray : NSObject, NSCoding{
    
    var animals : [Animals]
    
    init( animalsArray : [Animals]){
        self.animals = animalsArray
    }
    // MARK: - NSCoding
    required init(coder aDecoder: NSCoder) {
        animals = aDecoder.decodeObject(forKey: "animals") as? NSArray as! [Animals]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(animals, forKey: "animals")
    }
}
