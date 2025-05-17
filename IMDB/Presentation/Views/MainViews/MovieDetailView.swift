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
            VStack {
                HStack {
                    Spacer()
                    Text(detailViewModel.movieDetail?.status?.toString() ?? "")
                        .font(.caption)
                }
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w300\(detailViewModel.movieDetail?.posterPath?.toString() ?? "")"))
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                
                Text(detailViewModel.movieDetail?.title?.toString() ?? "")
                Text(detailViewModel.movieDetail?.overview?.toString() ?? "")
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
