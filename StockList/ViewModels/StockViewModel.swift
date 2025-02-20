//
//  StockViewModel.swift
//  StockList
//
//  Created by Max Shelepov on 2/19/25.
//

import Foundation
import Combine

class StockViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var searchResults: [StockSearchResult] = []

    func searchStocks(query: String) {
        StockAPIService.shared.searchStocks(query: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let results):
                        self?.searchResults = results
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func clearSearchResults() {
        searchResults = []
    }
}
