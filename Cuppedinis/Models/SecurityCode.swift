//
//  SecurityCode.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 7/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit
import ObjectMapper

class SecurityCode: Mappable {
    
    var length  : Int?
    var cardLocation: String?
    var mode: String?
    
    
    //MARK - Initializers
    required init?(map: Map) {
        
    }
    
    //MARK - Mapping
    func mapping(map: Map) {
        length <- map["length"]
        cardLocation <- map["card_location"]
        mode <- map["mode"]
        
    }
}
