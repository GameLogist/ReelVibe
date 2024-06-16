//
//  HomeScreenTrendingMovieCardView.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 15/06/24.
//

import SwiftUI

struct HomeScreenTrendingMovieCardView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var playlistViewModel: PlaylistViewModel
    @Binding var trendingAllDayMovies: [Movie]
    @Binding var trendingAllWeekMovies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Trending")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                
                HStack(spacing: 0) {
                    Text("Day")
                        .padding(6)
                        .background(homeScreenViewModel.trendingMovieToggle ? Color(.blue).opacity(0.2) : .blue)
                    Text("Week")
                        .padding(6)
                        .background(!homeScreenViewModel.trendingMovieToggle ? Color(.blue).opacity(0.2) : .blue)
                }
                .background(Color(.blue).opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .onTapGesture {
                    withAnimation {
                        homeScreenViewModel.trendingMovieToggle.toggle()
                    }
                }
            }
            .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    if(homeScreenViewModel.trendingMovieToggle) {
                        ForEach(0..<trendingAllDayMovies.count, id: \.self) { index in
                            MovieCard(movie: self.$trendingAllDayMovies[index])
                        }
                    } else {
                        ForEach(0..<trendingAllWeekMovies.count, id: \.self) { index in
                            MovieCard(movie: self.$trendingAllWeekMovies[index])
                        }
                    }
                }
                .padding(.bottom, 12)
            }
        }
        .background(Color(.blue).opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .padding()
    }
}
