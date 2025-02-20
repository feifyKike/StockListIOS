//
//  StockAPIService.swift
//  StockList
//
//  Created by Max Shelepov on 2/19/25.
//

import Foundation

import Foundation

struct StockSearchResult: Codable {
    let symbol: String
    let description: String
}

struct FinnhubSearchResponse: Codable {
    let result: [StockSearchResult]
}

class StockAPIService {
    static let shared = StockAPIService()
    private let apiKey = "..." // no longer valid.
    private let searchURL = "https://finnhub.io/api/v1/search"

    func searchStocks(query: String, completion: @escaping (Result<[StockSearchResult], Error>) -> Void) {
        guard let url = URL(string: "\(searchURL)?q=\(query)&token=\(apiKey)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }

            do {
                let decodedResponse = try JSONDecoder().decode(FinnhubSearchResponse.self, from: data)
                let results = decodedResponse.result
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
