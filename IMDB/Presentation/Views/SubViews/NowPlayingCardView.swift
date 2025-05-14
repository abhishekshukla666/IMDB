//
//  NowPlayingCardView.swift
//  IMDB
//
//  Created by Abhishek Shukla on 06/05/25.
//

import SwiftUI

struct NowPlayingCardView: View {
    
    let nowPlayingMovie: Movie
    
    var body: some View {
        VStack(alignment: .center) {
            LazyAsyncImage(imageURL: nowPlayingMovie.posterPath.getStringValue())
                .frame(width: 150, height: 225)
                .overlay(alignment: .bottomTrailing) {
                    Text("\(nowPlayingMovie.releaseDate.getStringValue())")
                        .foregroundStyle(.white)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .padding(8)
                        .font(.caption)
                        .background {
                            Capsule()
                                .fill(.gray)
                                
                        }
                        .padding([.bottom, .trailing], 4)
                }
            VStack(alignment: .leading) {
                Text(nowPlayingMovie.title.getStringValue())
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Text(nowPlayingMovie.overview?.getStringValue() ?? "")
                    .font(.caption)
                    .multilineTextAlignment(.leading)
            }
        }
        
    }
}

#Preview {
    NowPlayingCardView(nowPlayingMovie: Movie.sampleData_Single)
}
