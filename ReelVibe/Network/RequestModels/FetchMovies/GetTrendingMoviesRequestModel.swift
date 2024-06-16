//
//  GetTrendingMoviesRequestModel.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 11/06/24.
//

import Foundation

class GetTrendingAllDayMoviesRequestModel: RequestModel {
    
    override var path: String {
        return APIConstants.GetMovies.trendingAllDayMovies
    }
    
    override var method: HTTPMethod {
        return HTTPMethod.get
    }
}

class GetTrendingAllWeekMoviesRequestModel: RequestModel {
    
    override var path: String {
        return APIConstants.GetMovies.trendingAllWeekMovies
    }
    
    override var method: HTTPMethod {
        return HTTPMethod.get
    }
}
