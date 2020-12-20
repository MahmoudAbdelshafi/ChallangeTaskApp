//
//  CurrencyRepo.swift
//  challengeTask
//
//  Created by Mahmoud Abdelshafi on 12/20/20.
//

import Foundation

protocol CurrencyRepo {
    func listCurrency(completionHandeler: @escaping (Result<Currency,ErrorObject>)->Void)
}

class CurrencyRepoImpl: CurrencyRepo {
    func listCurrency(completionHandeler: @escaping (Result<Currency, ErrorObject>) -> Void) {
        ApiRequest.apiCall(responseModel: Currency.self, request: .latest) { response in
            switch response {
            case .success(let currency):
                completionHandeler(.success(currency))
            case .failure(let error):
                completionHandeler(.failure(error))
            }
        }
    }
}
