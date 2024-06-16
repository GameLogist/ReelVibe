//
//  PlaylistBottomSheetView.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 13/06/24.
//

import SwiftData
import SwiftUI

struct PlaylistBottomSheetView: View {
    
    @EnvironmentObject var playlistViewModel: PlaylistViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @Environment(\.modelContext) var modelContext
    @Query var playlists: [Playlist]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Playlists")
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
                                .foregroundColor(playlistViewModel.searchInPlaylist(playlist: playlist) ? Color(.systemGreen) : .black)
                            if(playlistViewModel.searchInPlaylist(playlist: playlist)) {
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
                            // Add/remove to this playlist
                            print("\(playlist.title) tapped!")
                            guard let movieToSearch = playlistViewModel.currentlyTappedMovie else {
                                print("Empty Movie Object!")
                                return
                            }
                            if(playlistViewModel.searchInPlaylist(playlist: playlist)) {
                                print("Remove from this playlist")
                                if let index = playlist.movies.firstIndex(where: {$0.id == movieToSearch.id}) {
                                    print("Movie Found to delete")
                                    playlist.movies.remove(at: index)
                                    homeScreenViewModel.updateMovieToPlaylistFilter(playlist: playlist)
                                }
                            } else {
                                print("Add to this playlist")
                                playlist.movies.append(movieToSearch)
                                homeScreenViewModel.updateMovieToPlaylistFilter(playlist: playlist)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            Text("+ Add a new Playlist")
                .padding([.leading, .bottom], 24)
                .onTapGesture {
                    playlistViewModel.showPlaylistAddAlert.toggle()
                }
            Spacer()
        }
        .tint(.blue)
        .alert("Enter your Playlist name!", isPresented: $playlistViewModel.showPlaylistAddAlert) {
            TextField("Enter Playlist name!", text: $playlistViewModel.title)
            Button {
                playlistViewModel.createNewPlaylist(context: modelContext)
            } label: {
                Text("Create")
            }
        } message: {
            Text("We will create a new playlist with this name for you")
        }
    }
}

