//
//  AllMoviesScreenView.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 12/06/24.
//

import SwiftUI

struct AllMoviesScreenView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var movies: [Movie]
    var cardType: eHomeScreenCardType
    
    var numberColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                   Image(systemName: "arrow.backward")
                       .resizable()
                       .scaledToFit()
                       .frame(width: 20, height: 25)
                       .padding(6)
               })
                .padding(.leading, 12)
               .buttonStyle(.borderedProminent)
               .buttonBorderShape(.circle)
               .tint(.blue.opacity(0.1))
               .foregroundStyle(.black)
                
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
            }
            ScrollView {
                LazyVGrid(columns: numberColumns, spacing: 20) {
                    ForEach(0..<movies.count, id: \.self) { index in
                        MovieCard(movie: self.$movies[index])
                    }
                }
            }
            .padding()
        }
        .background(.blue.opacity(0.1))
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
