//
//  GetNowPlayingMoviesRequestModel.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 15/06/24.
//

import Foundation

class GetNowPlayingRequestModel: RequestModel {
    
    override var path: String {
        return APIConstants.GetMovies.nowPlayingMovies
    }
    
    override var method: HTTPMethod {
        return HTTPMethod.get
    }
}
