//
//  SettingCardNumber.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 7/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit
import ObjectMapper

class CardNumber: Mappable {
    
    var validation: String?
    var length: Int?
    
    //MARK - Initializers
    required init?(map: Map) {
        
    }
    
    //MARK - Mapping
    func mapping(map: Map) {
        validation <- map["validation"]
        length <- map["length"]
    }
}

