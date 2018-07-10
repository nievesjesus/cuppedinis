//
//  payerCost.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 8/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit
import ObjectMapper

class payerCost: Mappable {
    
    var installments: Int?
    var installmentRate: Double?
    var discountRate: Double?
    var labels: [String]?
    var installmentRateCollector: [String]?
    var minAllowedAmount: Double?
    var maxAllowedAmount: Double?
    var recommendedMessage: String?
    var installmentAmount: Double?
    var totalAmount: Double?
    
    //MARK - Initializers
    required init?(map: Map) {
        
    }
    
    //MARK - Mapping
    func mapping(map: Map) {
        installments <- map["installments"]
        installmentRate <- map["installment_rate"]
        discountRate <- map["discount_rate"]
        labels <- map["labels"]
        installmentRateCollector <- map["installment_rate_collector"]
        minAllowedAmount <- map["min_allowed_amount"]
        maxAllowedAmount <- map["max_allowed_amount"]
        recommendedMessage <- map["recommended_message"]
        installmentAmount <- map["installment_amount"]
        totalAmount <- map["total_amount"]
    }
}
