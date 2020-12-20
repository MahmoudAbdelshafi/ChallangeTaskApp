//
//  APIRouter.swift
//  challengeTask
//
//  Created by Mahmoud Abdelshafi on 12/20/20.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    enum Constants {
        static var baseUrl = "http://data.fixer.io/api/"
    }
    
    case latest
    
    var url : URL {
        switch self {
        case .latest:
            return URL(string: "\(Constants.baseUrl)latest")!
        }
    }
    
    var method : HTTPMethod {
        switch self {
        case .latest:
            return .get
        }
    }
    
    var parameters : [String:Any]{
        switch self {
        case .latest:
            return ["access_key" : "6fef1544f372aafcb92754a1f07e6b4e"]
        }
    }
    
    var headers : HTTPHeaders{
        switch self {
        default:
            return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        urlRequest.headers = headers
        
        switch method {
        case .get, .delete:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}

