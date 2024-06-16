//
//  GetUpcomingMoviesRequestModel.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 11/06/24.
//

import Foundation

class GetUpcomingMoviesRequestModel: RequestModel {
    
    override var path: String {
        return APIConstants.GetMovies.upcomingMovies
    }
    
    override var method: HTTPMethod {
        return HTTPMethod.get
    }
}
