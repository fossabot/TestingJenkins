//
//  ModelClass.swift
//  ZoomingAnimation
//
//  Created by Manoj TR on 3/9/17.
//  Copyright © 2017 Manoj TR. All rights reserved.
//

import Foundation

class ModelClass {
    
    
    var mainImageURL: String?
    var Name: String?
    var Upc: String?
    var imageUrl: String?
    var Position: String?
    var Action: String?
    
    init(json: NSDictionary) {
//        if let imageUrl = (json["imageURL"] as? String) {
//            self.mainImageURL = imageUrl
//        }
        
        if let name = (json["name"] as? String) {
            self.Name = name
        }
        if let upc = (json["upc"] as? String) {
            self.Upc = upc
        }
        if let imageurl = (json["image"] as? String) {
            self.imageUrl = imageurl
        }
        
        if let position = (json["position"] as? String) {
            self.Position = position
        }
        if let action = (json["action"] as? String) {
            self.Action = action
        }
    }
    
}
