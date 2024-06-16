//
//  MovieCard.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 11/06/24.
//

import SwiftUI

struct MovieCard: View {
    
    @Binding var movie: Movie
    @EnvironmentObject var playlistViewModel: PlaylistViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: (NetworkConstants.shared.imageServerAddress + (movie.posterPath ?? ""))), content: view)
                CircularRatingView(rating: CGFloat((movie.voteAverage ?? 0)))
                    .padding(8)
                    .offset(y:15)
            }
            
            Text(movie.originalTitle ?? "Title Not Found!")
                .font(.system(size: 12))
                .fontWeight(.bold)
                .padding([.leading, .top], 8)
            
            Text(movie.releaseDate?.split(separator: "-")[0] ?? "2019")
                .font(.system(size: 14))
                .foregroundStyle(.secondary)
                .padding([.leading, .top], 8)
            
            Spacer()
        }
        .onLongPressGesture(perform: {
            playlistViewModel.currentlyTappedMovie = movie
            playlistViewModel.showBottomPlaylistSheet.toggle()
        })
        .frame(width: 140, height: 260)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
    
    // Async Image handler to show loader or error message
    @ViewBuilder
    private func view(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            ProgressView()
                .frame(width: 120, height: 180)
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 18))
        case .success(let image):
            image
                .resizable()
                .frame(width: 120, height: 180)
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 18))
        case .failure(let error):
            VStack(spacing: 16) {
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.red)
                Text(error.localizedDescription)
                    .multilineTextAlignment(.center)
            }
        @unknown default:
            Text("Unknown")
                .foregroundColor(.gray)
        }
    }
}
