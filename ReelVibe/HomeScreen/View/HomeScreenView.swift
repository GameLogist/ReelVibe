//
//  HomeScreenView.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 11/06/24.
//

import SwiftUI

struct HomeScreenView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
        
    var body: some View {
        ZStack {
            Color(.systemBlue.withAlphaComponent(0.1))
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    ForEach(homeScreenViewModel.homeScreenDataSource, id:\.self) { card in
                        if(card == .trending) {
                            HomeScreenTrendingMovieCardView(trendingAllDayMovies: $homeScreenViewModel.trendingAllDayMovies, trendingAllWeekMovies: $homeScreenViewModel.trendingAllWeekMovies)
                        } else {
                            HomeScreenMovieCardView(cardType: card)
                        }
                        Spacer()
                            .frame(height:12)
                    }
                    Spacer()
                }
                .environmentObject(homeScreenViewModel)
            }
        }
    }
}

#Preview {
    HomeScreenView()
}
