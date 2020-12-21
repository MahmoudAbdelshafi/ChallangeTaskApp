//
//  CurrencyMockRepo.swift
//  challengeTaskTests
//
//  Created by Mahmoud Abdelshafi on 12/21/20.
//

import Foundation

@testable import challengeTask

class CurrencyMockRepo: BaseRepoMock, CurrencyRepo {

    var getCurrencyResponse: Currency!
    
    func listCurrency(completionHandeler: @escaping (Result<Currency, ErrorObject>) -> Void) {
        shouldSuccess ? completionHandeler(.success(getCurrencyResponse)) : completionHandeler(.failure(failReponse))
    }
}
