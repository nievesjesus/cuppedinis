//
//  Api.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 7/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

class Cuppedinis {
    static let apikey = Bundle.main.object(forInfoDictionaryKey: "CuppedinisKey")
    static let provider = MoyaProvider<MeliApi>(plugins: [NetworkLoggerPlugin(verbose: false)])
    
    static func request(target: MeliApi, success successCallback: @escaping (Response) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                }
                else {
                    let error = NSError(domain:"com.nievesjesus.cuppedinis", code:0, userInfo:[NSLocalizedDescriptionKey: "Parsing Error"])
                    errorCallback(error)

                }
            case .failure(let error):
                failureCallback(error)
            }
        }
    }
    
    static func getPaymentMethods(success successCallback: @escaping (Array<PaymentMethod>) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
 
        self.request(target: .paymentMethods(), success: { (response) in
            do {
                let responseJSON:AnyObject = try response.mapJSON() as AnyObject
                let paymentsMethods = Mapper<PaymentMethod>().mapArray(JSONObject: responseJSON)
                successCallback(paymentsMethods!)
            } catch {
                errorCallback(error)
            }
        }, error: { (error) in
            errorCallback(error)
        }, failure: { (error) in
            failureCallback(error)
        })
    }
    
    static func getCardIssuers(payment: Payment, success successCallback: @escaping (Array<Issuer>) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        
        self.request(target: .cardIssuers(paymentMethodId: payment.paymentMethodId), success: { (response) in
            do {
                let responseJSON:AnyObject = try response.mapJSON() as AnyObject
                let issuers = Mapper<Issuer>().mapArray(JSONObject: responseJSON)
                successCallback(issuers!)
            } catch {
                errorCallback(error)
            }
        }, error: { (error) in
            errorCallback(error)
        }, failure: { (error) in
            failureCallback(error)
        })
    }
    
    static func getInstallments(payment: Payment, success successCallback: @escaping (Array<Installment>) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        
        self.request(target: .installments(amount: payment.amountValue, paymentMethodId: payment.paymentMethodId, issuerId: payment.issuerId), success: { (response) in
            do {
                let responseJSON:AnyObject = try response.mapJSON() as AnyObject
                let installments = Mapper<Installment>().mapArray(JSONObject: responseJSON)
                successCallback(installments!)
            } catch {
                errorCallback(error)
            }
        }, error: { (error) in
            errorCallback(error)
        }, failure: { (error) in
            failureCallback(error)
        })
    }
    
}
