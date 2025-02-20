//
//  HomeView.swift
//  StockList
//
//  Created by Max Shelepov on 2/19/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var stockViewModel = StockViewModel()
    @StateObject var myStockViewModel = MyStockViewModel()
    @State var searchQuery = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    if stockViewModel.searchResults.count > 0 {
                        ForEach(stockViewModel.searchResults, id: \.symbol) { stock in
                            AddStockView(stock: stock)
                                .environmentObject(myStockViewModel)
                        }
                    } else {
                        ForEach(myStockViewModel.myStocks, id: \.symbol) { stock in
                            HomeStockView(stock: stock)
                        }
                    }
                }
                .navigationTitle("Your Stocks")
                .searchable(text: $searchQuery, prompt: "Enter stock symbol")
                .onChange(of: searchQuery) { oldQ, newQ in
                    fetchStocks(query: newQ)
                }
            }
        }

    }
    
    func fetchStocks(query: String) {
        if (!query.isEmpty) {
            stockViewModel.searchStocks(query: query)
        } else {
            stockViewModel.clearSearchResults()
        }
    }
}

#Preview {
    HomeView()
}
