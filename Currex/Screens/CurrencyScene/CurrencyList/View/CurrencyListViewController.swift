//
//  CurrencyListViewController.swift
//  Currex
//
//  Created by Serhan Khan on 15/01/2021.
//


/**
 TODO://
 1) Currency converstion calculation
 2) Keep logic in view model
 3) Test for view model (create first test for currency conversion)
 4) Send request to get exchange rate for every two mins for only selected currencies
 5) Test this logic in view model
 
 */


import UIKit
import Combine

class CurrencyListViewController: BaseViewController {
    private let currencyListViewModel:CurrencyListViewModel
    private var currencies:[CurrencyListItemViewModel]? {
        didSet{
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView:BaseTableView!{
        willSet{
            newValue.delegate = self
            newValue.dataSource = self
            newValue.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 34))
            newValue.keyboardDismissMode = .onDrag
        }
    }
    
    @IBOutlet weak var activityIndicatorContainerView:UIView!{
        willSet{
            newValue.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        }
    }
    
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!{
        willSet{
            newValue.hidesWhenStopped = true 
        }
    }
    
    @IBOutlet weak var currencyConverterView:CurrencyConverterContainerView!
    
    init(viewModel:CurrencyListViewModel){
        self.currencyListViewModel = viewModel
        super.init(nibName: String(describing: CurrencyListViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = currencyListViewModel.screenTitle
    }
    
    override func executeRequests() {
        super.executeRequests()
        currencyListViewModel.initialExchangeRates()
    }
    
    override func configureObservers() {
        super.configureObservers()
        currencyListViewModel.currencyScreenState.sink(receiveValue: exchangeRate).store(in: &disposeBag)
        currencyConverterView.fromtextDidChange.sink(receiveValue: didFromTextDidChange).store(in: &disposeBag)
    }
    
    private func exchangeRate(with state:ScreenState<([CurrencyListItemViewModel],CurrencyListItemViewModel)>){
        switch state {
        case .error(let error):
            didReceiveNetworkError(error: error)
        case .finished:
            self.updateActivityIndicatorStatus(false)
        case .succes(data: (let currencies,let baseCurrencyListItemViewModel)):
            self.currencies = currencies
            self.currencyConverterView.fromExchangeRate = baseCurrencyListItemViewModel
        case .loading:
            self.updateActivityIndicatorStatus(true)
        case .noData:
            break
        }
    }
    
    private func updateActivityIndicatorStatus( _ isLoading:Bool){
        self.activityIndicatorContainerView.isHidden = !isLoading
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    private func didFromTextDidChange(value:String?){
        self.currencyListViewModel.convert(amount: value)
    }

}

extension CurrencyListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currencyListItemViewModel = currencies?.objectAt(index: indexPath.row) else {
            return UITableViewCell()
        }
        return ExchangeRateTableViewCell.create(tableView: tableView, currecyListItemViewModel: currencyListItemViewModel)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currencyListItemViewModel = currencies?.objectAt(index: indexPath.row) else {return}
        self.currencyConverterView.resetFromTextFieldText(value: nil)
        self.currencyListViewModel.exchangeRates(for: currencyListItemViewModel)
    }
}
