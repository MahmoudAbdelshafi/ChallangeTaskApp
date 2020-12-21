//
//  CurrencyViewController.swift
//  challengeTask
//
//  Created by Mahmoud Abdelshafi on 12/20/20.
//

import UIKit
import RxSwift
import RxCocoa
import ActionSheetPicker_3_0

class CurrencyViewController: UIViewController {
    
    //MARK:- Properties
    
    private var viewModel = CurrencyViewModel(currencyRepo: CurrencyRepoImpl())
    private var disposeBag = DisposeBag()
    private var countries = [String]()
    private let tableViewCellID = "CurrencyTableViewCell"
    
    //MARK:- IBOutlets
    
    @IBOutlet private weak var currencyPickerButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getCurrencyRates()
        currencyPickerButtonPressed()
        bindData()
    }
}

//MARK:- Private Fucntions

extension CurrencyViewController {
    
    private func bindData() {
        // self.subscribeErrorMessage()
        self.subscribeCurrencyRatesResponse()
        self.bindTableView()
    }
    
    private func subscribeCurrencyRatesResponse(){
        self.viewModel.currencyRatesResponse.bind { currencyRatesResponse in
            self.countries = currencyRatesResponse.map{$0.key}
        }.disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        self.viewModel.currencyRatesResponse.bind(to: tableView.rx.items(cellIdentifier: tableViewCellID, cellType: CurrencyTableViewCell.self)) {(row, currency, cell) in
            cell.configure(currencyName: currency.key, currencyValue: currency.value)
        }.disposed(by: disposeBag)
    }
    
    private func currencyPickerButtonPressed(){
        self.currencyPickerButton.rx.tap.bind {
            self.presentPickerView(content: self.countries)
        }.disposed(by: disposeBag)
    }
    
    private func subscribeErrorMessage(){
        self.viewModel.errorMessage.subscribe(onNext: { [weak self] errorMessage in
            self?.alert(message: errorMessage, actions: [("OK", .cancel)])
        }).disposed(by: disposeBag)
    }
    
    private func presentPickerView(content: [String]){
        let sortedContent = content.sorted()
        ActionSheetStringPicker.show(withTitle: "Countries", rows: sortedContent, initialSelection: 0, doneBlock: { _, _, value in
            self.viewModel.getCurrencyRates()
            self.currencyPickerButton.setTitle("\(value ?? "")", for: .normal)
            return
        }, cancel: { _ in return }, origin: UIButton())
    }
}
