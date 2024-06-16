//
//  MoviesServices.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 11/06/24.
//

import Foundation

import Foundation

class MoviesServices {
    class func getTrendingAllDayMovies(completion: @escaping(Swift.Result<TrendingMoviesResponseModel?, ErrorModel>) -> Void) {
        let request = GetTrendingAllDayMoviesRequestModel()
        NetworkManager.shared.sendRequest(requestModel: request) { (result) in
            completion(result)
        }
    }
    
    class func getTrendingAllWeekMovies(completion: @escaping(Swift.Result<TrendingMoviesResponseModel?, ErrorModel>) -> Void) {
        let request = GetTrendingAllWeekMoviesRequestModel()
        NetworkManager.shared.sendRequest(requestModel: request) { (result) in
            completion(result)
        }
    }
    
    class func getNowPlayingMovies(completion: @escaping(Swift.Result<NowPlayingResponseModel?, ErrorModel>) -> Void) {
        let request = GetTrendingAllWeekMoviesRequestModel()
        NetworkManager.shared.sendRequest(requestModel: request) { (result) in
            completion(result)
        }
    }
    
    class func getUpcomingMovies(completion: @escaping(Swift.Result<UpcomingMoviesResponseModel?, ErrorModel>) -> Void) {
        let request = GetUpcomingMoviesRequestModel()
        NetworkManager.shared.sendRequest(requestModel: request) { (result) in
            completion(result)
        }
    }
    
    class func getPopularMovies(completion: @escaping(Swift.Result<PopularMoviesResponseModel?, ErrorModel>) -> Void) {
        let request = GetPopularMoviesRequestModel()
        NetworkManager.shared.sendRequest(requestModel: request) { (result) in
            completion(result)
        }
    }
    
    class func getTopRatedMovies(completion: @escaping(Swift.Result<TopRatedMoviesResponseModel?, ErrorModel>) -> Void) {
        let request = GetTopRatedMoviesRequestModel()
        NetworkManager.shared.sendRequest(requestModel: request) { (result) in
            completion(result)
        }
    }
}
