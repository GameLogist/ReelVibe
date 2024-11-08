//
//  NetworkManager.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 11/06/24.
//

import Foundation

class NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    
    func sendRequest<T: Codable>(requestModel: RequestModel, completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) {
        
        guard let request = requestModel.urlRequest() else { return }
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(Result.failure(ErrorModel(errors: [ErrorSummary(code: "", reason: error.localizedDescription, datetime: nil)])))
                return
            }
            
            //check if data is empty
            guard let data = data else {
                completion(Result.failure(ErrorModel(errors: [ErrorSummary(code: "", reason: "no data received", datetime: nil)])))
                return
            }
            
            // Decoding data for Codable types with proper error handling
            do {
                let responseModel = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(responseModel))
            } catch {
                print("Failed to decode response: \(error.localizedDescription)")
                do {
                    let errorModel = try JSONDecoder().decode(ErrorModel.self, from: data)
                    completion(Result.failure(errorModel))
                } catch {
                    print("Failed to decode error response: \(error.localizedDescription)")
                    let fallbackError = ErrorModel(errors: [ErrorSummary(code: "", reason: "Failed to decode data", datetime: nil)])
                    completion(Result.failure(fallbackError))
                }
            }
            
        }.resume()
    }
}
