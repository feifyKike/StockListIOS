//
//  MyStock.swift
//  StockList
//
//  Created by Max Shelepov on 2/20/25.
//
import Foundation

struct MyStock: Identifiable, Codable, Hashable {
    let id: String?
    
    let symbol: String
    let description: String
    
    init(id: String? = nil, symbol: String, description: String) {
        self.id = id
        self.symbol = symbol
        self.description = description
    }
}
