//
//  HomeScreenMovieCardView.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 12/06/24.
//

import SwiftUI
import SwiftData

struct HomeScreenMovieCardView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var playlistViewModel: PlaylistViewModel
    @Query var playlists: [Playlist]
    
    var cardType: eHomeScreenCardType
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(cardType.rawValue)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                Image(systemName: homeScreenViewModel.showBottomPlaylistFilterSheet ? "chevron.up" : "chevron.down")
                    .onTapGesture {
                        withAnimation {
                            homeScreenViewModel.currentlyTappedSection = cardType
                            homeScreenViewModel.showBottomPlaylistFilterSheet.toggle()
                        }
                    }
                
                Spacer()
                
                NavigationLink(destination:
                                AllMoviesScreenView(movies: getMovieDataBinding(cardType: cardType), cardType: cardType)
                    .navigationTitle(cardType.rawValue).environmentObject(playlistViewModel)
                    .environmentObject(homeScreenViewModel)) {
                        HStack {
                            Text("all")
                                .font(.system(size: 16))
                                .foregroundColor(Color(.black))
                                .fontWeight(.bold)
                            Image(systemName: "chevron.right")
                                .imageScale(.small)
                                .foregroundColor(Color(.black))
                        }
                        .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
                        .background(Color(.blue).opacity(0.2))
                        .clipShape(.capsule)
                        .padding()
                    }
            }
            
            if(getMovieDataBinding(cardType: cardType).isEmpty) {
                Text("No movies math your playlist filter.")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(0..<getMovieDataBinding(cardType: cardType).count, id: \.self) { index in
                            MovieCard(movie: getMovieDataBinding(cardType: cardType)[index])
                        }
                    }
                    .padding(.bottom, 12)
                }
        }
        }
        .background(Color(.blue).opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .padding()
    }
    
    func getMovieDataBinding(cardType: eHomeScreenCardType) -> Binding<[Movie]> {
        switch cardType {
        case .trending:
            $homeScreenViewModel.filteredTrendingAllDayMovies
        case .nowPlaying:
            $homeScreenViewModel.filteredNowPlayingMovies
        case .upcoming:
            $homeScreenViewModel.filteredUpcomingMovies
        case .popular:
            $homeScreenViewModel.filteredPopularMovies
        case .topRated:
            $homeScreenViewModel.filteredTopRatedMovies
        }
    }
}
