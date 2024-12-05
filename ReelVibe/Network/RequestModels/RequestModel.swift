//
//  RequestModel.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 11/06/24.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

class RequestModel: NSObject {
    
    // MARK: - Properties
    
    // new property that handles different baseUrl
    var customBaseUrl: String {
        return ""
    }
    
    var path: String {
        return ""
    }
    
    var parameters: [String: Any?] {
        return [:]
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var method: HTTPMethod {
        return body.isEmpty ? HTTPMethod.get : HTTPMethod.post
    }
    
    var body: [String: Any?] {
        return [:]
    }
    
    var token: String {
        // One can store this in user defaults as well
        return NetworkConstants.shared.apiReadAccessToken
    }
}

extension RequestModel {
    
    func urlRequest() -> URLRequest? {
        var endpoint: String = customBaseUrl != "" ? customBaseUrl.appending(path) : NetworkConstants.shared.baseUrl.appending(path)

        var flag: Bool = true
        for parameter in parameters {
            if let value = parameter.value {
                if flag {
                    flag = false
                    endpoint.append("?\(parameter.key)=\(value)")
                } else {
                    endpoint.append("&\(parameter.key)=\(value)")
                }
            }
        }
        
        guard let url = URL(string: endpoint) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if method != .get {
            if method == .post || method == .put || method == .patch {
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                
                // Handle URL encoding of the body parameters
                let urlEncodedString = body.compactMap { (key, value) -> String? in
                    guard let value = value else { return nil }
                    return "\(key)=\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                }.joined(separator: "&")
                request.httpBody = urlEncodedString.data(using: .utf8)
            } else {
                // Use JSON encoding for other types if necessary
                do {
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
                } catch let error {
                    print("Request body parse error: \(error.localizedDescription)")
                }
            }
        }
        
        return request
    }
}
