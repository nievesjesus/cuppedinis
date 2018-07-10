//
//  PaymentModelController.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 8/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import Foundation

class PaymentModelController {
    var payment = Payment(
        amount: "",
        amountValue: 0.00,
        paymentMethodId: "",
        paymentMethodName: "",
        issuerId: "",
        issuerName: "",
        payerCostDescription: "",
        completed: false
    )
}
