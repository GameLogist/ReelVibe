//
//  GetPopularMoviesRequestModel.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 11/06/24.
//

import Foundation

class GetPopularMoviesRequestModel: RequestModel {
    
    override var path: String {
        return APIConstants.GetMovies.popularMovies
    }
    
    override var method: HTTPMethod {
        return HTTPMethod.get
    }
}
