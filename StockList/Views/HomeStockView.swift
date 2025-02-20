//
//  HomeStockView.swift
//  StockList
//
//  Created by Max Shelepov on 2/20/25.
//

import SwiftUI

struct HomeStockView: View {
    @EnvironmentObject var myStockViewModel: MyStockViewModel
    var stock: MyStock
    
    init(stock: MyStock) {
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
            Text("$123.45")
        }
    }
}

#Preview {
    HomeStockView(stock: MyStock(symbol: "AAPL", description: "Apple Inc."))
}
