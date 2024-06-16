//
//  ReelVibeApp.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 11/06/24.
//

import SwiftData
import SwiftUI

@main
struct ReelVibeApp: App {
    
    @StateObject var playlistViewModel: PlaylistViewModel = PlaylistViewModel()
    @StateObject var homeScreenViewModel: HomeScreenViewModel = HomeScreenViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeScreenView()
                    .environmentObject(playlistViewModel)
                    .environmentObject(homeScreenViewModel)
            }
            .modelContainer(for: Playlist.self)
            .sheet(isPresented: $playlistViewModel.showBottomPlaylistSheet) {
                PlaylistBottomSheetView()
                    .environmentObject(playlistViewModel)
                    .environmentObject(homeScreenViewModel)
                    .presentationDetents([.height(300), .medium])
                    .presentationDragIndicator(.visible)
                /*interactiveDismissDisabled*/
            }
            .sheet(isPresented: $homeScreenViewModel.showBottomPlaylistFilterSheet) {
                PlaylistBottomFilterSheetView()
                    .environmentObject(playlistViewModel)
                    .environmentObject(homeScreenViewModel)
                    .presentationDetents([.height(300), .medium])
                    .presentationDragIndicator(.visible)
                /*interactiveDismissDisabled*/
            }
        }
        .modelContainer(for: Playlist.self)
    }
}
