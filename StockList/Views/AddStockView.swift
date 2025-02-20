//
//  AddStockView.swift
//  StockList
//
//  Created by Max Shelepov on 2/19/25.
//

import SwiftUI

struct AddStockView: View {
    @EnvironmentObject var myStockViewModel: MyStockViewModel
    var stock: StockSearchResult
    
    @State private var addingStock = false
    @State private var addedStock = false
    
    init(stock: StockSearchResult) {
        self.stock = stock
    }
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 5) {
                Text(stock.symbol)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(stock.description)
                    .font(.caption)
            }
            Spacer()
            if !addedStock {
                Button(action: {
                    addingStock = true
                    myStockViewModel.addStock(symbol: stock.symbol, description: stock.description)
                    addingStock = false
                    addedStock = true
                }) {
                    Label("Add", systemImage: "plus.circle.fill")
                        .foregroundColor(.green)
                        .padding()
                }
            } else {
                Label("Added", systemImage: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .padding()
            }
            
        }
    }
}

#Preview {
    AddStockView(stock: StockSearchResult(symbol: "AAPL", description: "Apple Inc."))
}
