//
//  Issuer.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 8/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit
import ObjectMapper

class Issuer: Mappable {
    
    var id  : String?
    var name: String?
    var secureThumbnail: String?
    var thumbnail: String?
    var processingMode: String?
    var merchantAccountId: String?
    //MARK - Initializers
    required init?(map: Map) {
        
    }
    
    //MARK - Mapping
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        secureThumbnail <- map["secure_thumbnail"]
        thumbnail <- map["thumbnail"]
        processingMode <- map["processing_mode"]
        merchantAccountId <- map["merchant_account_id"]
    }
}
