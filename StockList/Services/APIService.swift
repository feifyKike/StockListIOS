//
//  APIService.swift
//  StockList
//
//  Created by Max Shelepov on 2/19/25.
//

import Foundation

let API_URL = "https://localhost:8080"

class APIService {
    static let shared = APIService()
    
    func getAllStocks(completion: @escaping (Result<[MyStock], Error>) -> Void) {
        // Replace with your Vapor endpoint URL.
        guard let url = URL(string: "\(API_URL)/stocks") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    // Decode the data into an array of MyStock
                    let stocks = try JSONDecoder().decode([MyStock].self, from: data)
                    completion(.success(stocks)) // Return the decoded stocks
                } catch {
                    completion(.failure(error)) // Handle JSON decoding error
                }
            }
        }.resume()
    }
    
    func addStock(symbol: String, description: String, completion: @escaping (Result<MyStock, Error>) -> Void) {
        // Replace with your Vapor endpoint URL
        guard let url = URL(string: "\(API_URL)/stocks") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create the body data with the StockDTO structure
        let stockDTO = ["symbol": symbol, "description": description]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: stockDTO, options: [])
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        // Perform the POST request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                do {
                    // Decode the response data into MyStock
                    let stock = try JSONDecoder().decode(MyStock.self, from: data)
                    completion(.success(stock)) // Return the decoded stock
                } catch {
                    completion(.failure(error)) // Handle JSON decoding error
                }
            }
        }.resume()
    }
}
