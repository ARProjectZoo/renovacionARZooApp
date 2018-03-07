//
//  User.swift
//  ReproductorMusicaJulio
//
//  Created by Kike on 1/2/18.
//  Copyright © 2018 julio. All rights reserved.
//

import Foundation

class User{
    let userName : String
    let email : String
    //    let photo : String
    
    init(json : NSDictionary){
        self.userName = json["userName"] as! String
        self.email = json["userEmail"] as! String
    }
}

