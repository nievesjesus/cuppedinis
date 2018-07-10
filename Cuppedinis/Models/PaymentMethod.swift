//
//  PaymenthMethod.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 7/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit
import ObjectMapper

class PaymentMethod: Mappable {
    
    var id: String?
    var name: String?
    var paymentTypeId: String?
    var status: String?
    var secureThumbnail: String?
    var thumbnail: String?
    var deferredCapture: String?
    var settings: [PaymentSetting]?
    var additionalInfoNeeded: [String]?
    var minAllowedAmount: Int!
    var maxAllowedAmount: Int!
    var financialInstitutions: [String]?
    var processingModes: [String]?
    
    //MARK - Initializers
    required init?(map: Map) {
        
    }
    
    //MARK - Mapping
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        paymentTypeId <- map["payment_type_id"]
        status <- map["status"]
        secureThumbnail <- map["secure_thumbnail"]
        thumbnail <- map["thumbnail"]
        deferredCapture <- map["deferred_capture"]
        settings <- map["settings"]
        additionalInfoNeeded <- map["additional_info_needed"]
        minAllowedAmount <- map["min_allowed_amount"]
        maxAllowedAmount <- map["max_allowed_amount"]
        financialInstitutions <- map["financial_institutions"]
        processingModes <- map["processing_modes"]
    }
}
