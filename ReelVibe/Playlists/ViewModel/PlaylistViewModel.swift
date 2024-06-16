//
//  PlaylistViewModel.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 12/06/24.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
class PlaylistViewModel: ObservableObject {
    
    @Published var showBottomPlaylistSheet: Bool = false
    @Published var showPlaylistAddAlert = false
    @Published var title: String = ""
    @Published var currentlyTappedMovie: Movie?
    
    func createNewPlaylist(context: ModelContext) {
        guard let item = currentlyTappedMovie else { return }
        let playlist = Playlist(id: UUID(), title: title)
        playlist.movies.append(item)
        context.insert(playlist)
    }
    
    func searchInPlaylist(playlist: Playlist) -> Bool {
        guard let movie = currentlyTappedMovie else { return false }
        return playlist.movies.filter{$0.id == movie.id}.count > 0
    }
}
