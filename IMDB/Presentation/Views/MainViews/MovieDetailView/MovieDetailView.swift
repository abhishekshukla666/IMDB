//
//  MovieDetailView.swift
//  IMDB
//
//  Created by Abhishek Shukla on 14/05/25.
//

import SwiftUI

struct MovieDetailView: View {
    
    @StateObject var detailViewModel: MovieDetailViewModel = .init(MoviesService())
    let movieId: Int
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                
                HStack(alignment: .center) {
                    Text(detailViewModel.movieDetail?.title?.toString() ?? "")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                    Image(systemName: "heart")
                }
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w300\(detailViewModel.movieDetail?.posterPath?.toString() ?? "")"))
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .clipped()
                
                
                Text(detailViewModel.movieDetail?.overview?.toString() ?? "")
                    .font(.caption)
                
                HStack {
                    Spacer()
                    VStack {
                        Text(detailViewModel.movieDetail?.status?.toString() ?? "")
                            .font(.headline.italic())
                            .multilineTextAlignment(.trailing)
                        if let isAdult = detailViewModel.movieDetail?.adult?.toString(), isAdult == "true" {
                            Text("A")
                                .font(.headline)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    
                }
            }
            .padding()
            .task {
                await detailViewModel.fetchMovieDetail(movieId: movieId)
            }
        }
    }
}

#Preview {
    MovieDetailView(movieId: 238)
}
