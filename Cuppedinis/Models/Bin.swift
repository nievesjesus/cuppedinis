//
//  SettingBin.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 7/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit
import ObjectMapper

class Bin: Mappable {
    
    var pattern  : String?
    var installmentsPattern: String?
    var exclusionPattern: String?
    
    
    //MARK - Initializers
    required init?(map: Map) {
        
    }
    
    //MARK - Mapping
    func mapping(map: Map) {
        pattern <- map["pattern"]
        installmentsPattern <- map["installments_pattern"]
        exclusionPattern <- map["exclusion_pattern"]
        
    }
}
