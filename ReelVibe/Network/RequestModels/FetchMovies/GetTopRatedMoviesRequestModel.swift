//
//  GetTopRatedMoviesRequestModel.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 11/06/24.
//

import Foundation

class GetTopRatedMoviesRequestModel: RequestModel {
    
    override var path: String {
        return APIConstants.GetMovies.topRatedMovies
    }
    
    override var method: HTTPMethod {
        return HTTPMethod.get
    }
}
