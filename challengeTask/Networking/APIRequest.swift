//
//  APIRequest.swift
//  challengeTask
//
//  Created by Mahmoud Abdelshafi on 12/20/20.
//

import Foundation
import Alamofire

class ApiRequest{
    static func apiCall<T : Decodable>(responseModel: T.Type, request : ApiRouter,  completionHandeler: @escaping (Result<T,ErrorObject>) -> Void) {
        AF.request(request).responseData { (response : AFDataResponse<Data>) in
            switch response.result{
            
            case .success(let result):
                if let statusCode = response.response?.statusCode, (200...299).contains(statusCode)  {
                    if let obj = try? JSONDecoder().decode(T.self, from: result){
                        completionHandeler(.success(obj))
                    } else {
                        guard let errorObject = try? JSONDecoder().decode(ErrorObject.self, from: result) else {return}
                        completionHandeler(.failure(errorObject))
                    }
                } else {
                    guard let errorObject = try? JSONDecoder().decode(ErrorObject.self, from: result) else {return}
                    completionHandeler(.failure(errorObject))
                }
                
            case .failure(let error):
                completionHandeler(.failure(ErrorObject(success: false, error: ErrorInfo(code: 0, info: error.localizedDescription))))
            }
        }
    }
}

