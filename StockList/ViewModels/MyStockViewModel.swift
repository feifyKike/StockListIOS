//
//  MyStockViewModel.swift
//  StockList
//
//  Created by Max Shelepov on 2/19/25.
//
import Foundation
import Combine

class MyStockViewModel: ObservableObject {
    @Published var myStocks: [MyStock] = []
    @Published var errorMessage: String?
    
    init() {
        // Fetch stocks at instantiation.
        APIService.shared.getAllStocks { result in
            switch result {
                case .success(let stocks):
                    self.myStocks = stocks
                case .failure(let error):
                    // Handle the error
                    self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func addStock(symbol: String, description: String) {
        APIService.shared.addStock(symbol: symbol, description: description) { result in
            switch result {
                case .success(let stock):
                    self.myStocks.append(stock)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
            }
        }
    }
    
}
