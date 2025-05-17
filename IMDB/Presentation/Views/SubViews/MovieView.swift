//
//  MovieView.swift
//  IMDB
//
//  Created by Abhishek Shukla on 07/05/25.
//

import SwiftUI
import CTRating2

struct MovieView: View {
    
    @EnvironmentObject var navigationPath: NavigationManager
    let movie: Movie
    
       var body: some View {
           HStack(alignment: .center, spacing: 10) {
               //Image
               LazyAsyncImage(imageURL: movie.posterPath.toString())
                   .frame(width: 150, height: 220)
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
               
               
               VStack(alignment: .leading, spacing: 12) {
                   Text("\(movie.title.toString())")
                       .font(.headline)
                   Text("\(movie.overview?.toString() ?? "No Overview")")
                       .font(.caption)
                       .lineLimit(8)
                   HStack(alignment: .center, spacing: 4.0) {
                       StaticRatingsView(ratingValue: (movie.voteAverage?.toDouble() ?? 0.0), width: 10, startCount: 10, spacing: 4.0)
                           .font(.caption)
                       Text("(\(movie.voteCount?.toString() ?? "0")) ")
                           .font(.caption)
                   }
               }
           }
           .onTapGesture {
               navigationPath.push(.movieDetailView(movieId: movie.id))
           }
           .padding(.vertical, 5)
           .padding(.horizontal, 10)
       }
   }

#Preview {
    MovieView(movie: Movie.sampleData_Single)
}
