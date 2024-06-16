//
//  PlaylistBottomFilterSheetView.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 15/06/24.
//

import SwiftUI
import SwiftData

struct PlaylistBottomFilterSheetView: View {
    
    @EnvironmentObject var playlistViewModel: PlaylistViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @Environment(\.modelContext) var modelContext
    @Query var playlists: [Playlist]
    
    var body: some View {
        VStack(alignment: .leading) {
            if(playlists.isEmpty) {
                Text("You have no playlists! :( Lets add a new one!")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .padding([.leading, .top], 8)
            } else {
                Text("Filter by Playlists")
                    .font(.title)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding([.leading, .top], 24)
                ScrollView {
                    VStack {
                        ForEach(playlists, id: \.self) { playlist in
                            HStack {
                                Text(playlist.title)
                                    .font(.system(size: 18))
                                    .fontWeight(.regular)
                                    .foregroundColor(homeScreenViewModel.searchInPlaylistFilters(playlist: playlist) ? Color(.systemGreen) : .black)
                                if(homeScreenViewModel.searchInPlaylistFilters(playlist: playlist)) {
                                    Image(systemName: "checkmark")
                                        .imageScale(.small)
                                        .foregroundColor(Color(.systemGreen))
                                }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .frame(alignment: .leading)
                            .padding([.leading, .bottom], 24)
                            .onTapGesture {
                                // Add/remove to global filter
                                print("\(playlist.title) tapped!")
                                if(homeScreenViewModel.searchInPlaylistFilters(playlist: playlist)) {
                                    homeScreenViewModel.removePlaylistToFilterBy(playlist: playlist)
                                } else {
                                    homeScreenViewModel.addPlaylistToFilterBy(playlist: playlist)
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .tint(.blue)
    }
}

#Preview {
    PlaylistBottomFilterSheetView()
}
