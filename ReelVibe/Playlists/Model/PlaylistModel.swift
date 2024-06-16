//
//  PlaylistModel.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 13/06/24.
//

import Foundation
import SwiftData

@Model
class Playlist {
    var id: UUID
    var movies: [Movie] = []
    var title: String
    
    init(id: UUID, movies: [Movie] = [], title: String) {
        self.id = id
        self.movies = movies
        self.title = title
    }
}
