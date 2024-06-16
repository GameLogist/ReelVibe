//
//  CircularRatingView.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 12/06/24.
//

import SwiftUI

struct CircularRatingView: View {
  let rating: CGFloat

  var body: some View {
    ZStack {
        Circle()
            .foregroundColor(.white)
            .frame(width: 35, height: 35)
        // Background for the progress bar
        Circle()
            .stroke(lineWidth: 1)
            .opacity(0.1)
            .foregroundColor(.blue)
            .frame(width: 35, height: 35)

        // Foreground or the actual progress bar
        Circle()
            .trim(from: 0.0, to: min(rating/10, 1.0))
            .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
            .foregroundColor(getColorBasedOnRating())
            .rotationEffect(Angle(degrees: 270.0))
            .animation(.linear, value: rating/10)
            .frame(width: 30, height: 30)
        
        Text("\(rating, specifier: "%.1f")")
            .font(.system(size: 12))
    }
  }
    
    func getColorBasedOnRating() -> Color {
        if(rating < 8 && rating >= 6) { return Color.yellow }
        else if(rating < 6 && rating >= 4) { return Color.orange }
        else if(rating < 4 && rating >= 0) { return Color.red }
        return Color.green
    }
}

#Preview {
    CircularRatingView(rating: 7.2)
}
