//
//  Responses.swift
//  ReproductorMusicaJulio
//
//  Created by Kike on 30/1/18.
//  Copyright © 2018 julio. All rights reserved.
//

import Foundation

class Responses{
    
    let code : Int!
    let message : String!
    let data : Any!
    
    init(jsonData : [String : Any]){
        self.code = jsonData["code"] as! Int
        self.message = jsonData["message"] as! String
        self.data = jsonData["data"]
    }
    
    
    init(json : [String : Any]){
        self.code = json["code"] as! Int
        self.message = json["message"] as! String
        self.data = json["data"]
    }
    
    init(code : Int , message : String , data : [String : Any]){
        self.code = code
        self.message = message
        self.data = data
       
    }
    
    
}
extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}

