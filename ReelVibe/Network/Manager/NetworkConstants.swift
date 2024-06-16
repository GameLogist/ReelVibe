//
//  NetworkConstants.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 11/06/24.
//

import Foundation

class NetworkConstants {
    public static var shared: NetworkConstants = NetworkConstants()
    
    private init() {
        // Singleton
    }
    
    public var apiKey: String {
        get {
            return "c06c163fab0358ff4f2939bb8f52ddd7"
        }
    }
    
    public var apiReadAccessToken: String {
        get {
            return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMDZjMTYzZmFiMDM1OGZmNGYyOTM5YmI4ZjUyZGRkNyIsInN1YiI6IjY2NjgyOWE5N2NiZWQyZmVmM2JlYTAwZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3hy606_jOfQDvwg_eMZKlLfY2gUhTlTiPFbUaB9kJhQ"
        }
    }
    
    public var serverAddress: String {
        get {
            return "https://api.themoviedb.org/3/"
        }
    }
    
    public var imageServerAddress: String {
        get {
            return "https://image.tmdb.org/t/p/w500"
        }
    }
}
