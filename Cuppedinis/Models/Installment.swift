//
//  Installment.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 8/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit
import ObjectMapper

class Installment: Mappable {
    
    var paymentMethodId: String?
    var paymentTypeId: String?
    var issuer: Issuer?
    var processingMode: String?
    var merchantAccountId: String?
    var payerCosts: [payerCost]?
    
    //MARK - Initializers
    required init?(map: Map) {
        
    }
    
    //MARK - Mapping
    func mapping(map: Map) {
        paymentMethodId <- map["payment_method_id"]
        paymentTypeId <- map["payment_type_id"]
        issuer <- map["issuer"]
        processingMode <- map["processing_mode"]
        merchantAccountId <- map["merchant_account_id"]
        payerCosts <- map["payer_costs"]
    }
}
