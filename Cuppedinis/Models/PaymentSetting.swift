//
//  PaymenthSetting.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 7/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit
import ObjectMapper

class PaymentSetting: Mappable {
    
    var cardNumber: CardNumber?
    var bin: Bin?
    var securityCode: SecurityCode?
    
    //MARK - Initializers
    required init?(map: Map) {
        
    }
    
    //MARK - Mapping
    func mapping(map: Map) {
        cardNumber <- map["card_number"]
        bin <- map["bin"]
        securityCode <- map["security_code"]
    }
}

