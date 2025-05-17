//
//  NowPlayingCardView.swift
//  IMDB
//
//  Created by Abhishek Shukla on 06/05/25.
//

import SwiftUI

struct MovieCardView: View {
    
    let nowPlayingMovie: Movie
    
    var body: some View {
        VStack(alignment: .center) {
            LazyAsyncImage(imageURL: nowPlayingMovie.posterPath.toString())
                .frame(width: 150, height: 225)
                .overlay(alignment: .bottomTrailing) {
                    Text(
                        "\(nowPlayingMovie.releaseDate.toString().toDateString(format: "dd-MMM-yyyy"))"
                    )
                        .foregroundStyle(.white)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .padding(8)
                        .font(.caption)
                        .background {
                            Capsule()
                                .fill(.secondary)
                                
                        }
                        .padding([.bottom, .trailing], 4)
                }
            VStack(alignment: .leading) {
                Text(nowPlayingMovie.title.toString())
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Text(nowPlayingMovie.overview?.toString() ?? "")
                    .font(.caption)
                    .multilineTextAlignment(.leading)
            }
        }
        
    }
}

#Preview {
    MovieCardView(nowPlayingMovie: Movie.sampleData_Single)
}
