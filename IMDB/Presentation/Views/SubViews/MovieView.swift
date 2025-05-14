//
//  MovieView.swift
//  IMDB
//
//  Created by Abhishek Shukla on 07/05/25.
//

import SwiftUI
import CTRating2

struct MovieView: View {
    
    let movie: Movie
    
       var body: some View {
           HStack(alignment: .center, spacing: 10) {
               //Image
               LazyAsyncImage(imageURL: movie.posterPath.getStringValue())
                   .frame(width: 150, height: 220)
               
               VStack(alignment: .leading, spacing: 12) {
                   Text("\(movie.title.getStringValue())")
                       .font(.headline)
                   Text("\(movie.overview?.getStringValue() ?? "No Overview")")
                       .font(.caption)
                   HStack(alignment: .center, spacing: 4.0) {
                       StaticRatingsView(ratingValue: (movie.voteAverage?.getDoubleValue() ?? 0.0), width: 10, startCount: 10, spacing: 4.0)
                           .font(.caption)
                       Text("(\(movie.voteCount?.getStringValue() ?? "0")) ")
                           .font(.caption)
                   }
               }
           }
           .padding(.vertical, 5)
           .padding(.horizontal, 10)
       }
   }

#Preview {
    MovieView(movie: Movie.sampleData_Single)
}
