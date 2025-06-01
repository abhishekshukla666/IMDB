//
//  NowPlayingCardView.swift
//  IMDB
//
//  Created by Abhishek Shukla on 06/05/25.
//

import SwiftUI

struct MovieCardView: View {
    
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            LazyAsyncImage(imageURL: movie.posterPath.toString())
                .frame(width: 150, height: 225)
                .overlay(alignment: .bottomTrailing) {
                    Text(
                        "\(movie.releaseDate.toString().toDateString(format: "dd-MMM-yyyy"))"
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
                Text(movie.title.toString())
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Text(movie.overview?.toString() ?? "")
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
        }
        
    }
}

#Preview {
    MovieCardView(movie: Movie.sampleData_Single)
}
