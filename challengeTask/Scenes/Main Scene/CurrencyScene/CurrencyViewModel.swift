//
//  CurrencyViewModel.swift
//  challengeTask
//
//  Created by Mahmoud Abdelshafi on 12/20/20.
//

import Foundation
import RxSwift
import RxCocoa

class CurrencyViewModel {

    //MARK:- Properties
    
    var currencyRepo: CurrencyRepo
    var currencyRatesResponse: Observable<[String: Double]>{return currencyRatesSubject}
    var errorMessage = BehaviorRelay<String>(value: "")
    private var currencyRatesSubject = PublishSubject<[String: Double]>()
    
    init(currencyRepo: CurrencyRepo) {
        self.currencyRepo = currencyRepo
    }
    
    func getCurrencyRates() {
        self.currencyRepo.listCurrency { [weak self] response in
            switch response {
            case .success(let currency):
                self?.currencyRatesSubject.onNext(currency.rates ?? ["":0.0])
            case .failure(let error):
                self?.errorMessage.accept(error.error.info)
            }
        }
    }
}
