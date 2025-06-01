//
//  NowPlayingView.swift
//  IMDB
//
//  Created by Abhishek Shukla on 06/05/25.
//

import SwiftUI

struct MoviesCarousalView: View {
    
    @EnvironmentObject var navigationPath: NavigationManager
    let headerTitle: String
    let movies: [Movie]
    
    let moreButtonAction: () -> Void
    
    var body: some View {
        Section(header: header().headerProminence(.increased)) {
            ScrollView(.horizontal) {
                LazyHStack(
                    alignment: .top,
                    spacing: 8,
                    pinnedViews: [.sectionHeaders]
                ) {
                    ForEach(movies) { movie in
                        MovieCardView(movie: movie)
                            .frame(width: 150, height: 310)
                            .onTapGesture {
                                navigationPath.push(.movieDetailView(movieId: movie.id))
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 10)
        }
    }
    
    @ViewBuilder
    func header() -> some View {
        HStack {
            Text(headerTitle)
                .font(.headline)
                .foregroundStyle(.white)

            Spacer()
            Button {
                moreButtonAction()
            } label: {
                Text("More")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(apptint.opacity(0.6).gradient)
    }
}

#Preview {
    MoviesCarousalView(headerTitle: "Now Playing", movies: Movie.sampleData_Multiples, moreButtonAction: {})
        
}
