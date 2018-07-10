//
//  MeliEndPoint.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 7/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import Foundation
import Moya

public enum MeliApi {
    case paymentMethods()
    case cardIssuers(paymentMethodId: String)
    case installments(amount: Double, paymentMethodId: String, issuerId: String)
}

extension MeliApi: TargetType {
    
    public var baseURL: URL {
        guard let url = URL(string: "https://api.mercadopago.com/v1/") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    public var path: String {
        switch self {
        case .paymentMethods:
            return "payment_methods"
        case .cardIssuers:
            return "payment_methods/card_issuers"
        case .installments:
            return "payment_methods/installments"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .paymentMethods, .cardIssuers, .installments:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .paymentMethods:
            var parameters = [String: Any]()
            parameters["public_key"] = Cuppedinis.apikey
            return parameters
        case .cardIssuers(let paymentMethodId):
            var parameters = [String: Any]()
            parameters["public_key"] = Cuppedinis.apikey
            parameters["payment_method_id"] = paymentMethodId
            return parameters
        case .installments(let amount, let paymentMethodId, let issuerId):
            var parameters = [String: Any]()
            parameters["public_key"] = Cuppedinis.apikey
            parameters["amount"] = amount
            parameters["payment_method_id"] = paymentMethodId
            parameters["issuer.id"] = issuerId
            return parameters
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .paymentMethods, .cardIssuers, .installments:
            return URLEncoding.queryString
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    
    public var task: Task {
        switch self {
        case .paymentMethods():
            var parameters = [String: Any]()
            parameters["public_key"] = Cuppedinis.apikey
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .cardIssuers(let paymentMethodId):
            var parameters = [String: Any]()
            parameters["public_key"] = Cuppedinis.apikey
            parameters["payment_method_id"] = paymentMethodId
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .installments(let amount, let paymentMethodId, let issuerId):
            var parameters = [String: Any]()
            parameters["public_key"] = Cuppedinis.apikey
            parameters["amount"] = amount
            parameters["payment_method_id"] = paymentMethodId
            parameters["issuer.id"] = issuerId
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
    
}
