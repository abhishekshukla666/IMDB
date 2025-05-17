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
        Section(header:
                    header()
        ) {
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, pinnedViews: [.sectionHeaders]) {
                    ForEach(movies) { movie in
                        MovieCardView(nowPlayingMovie: movie)
                            .frame(width: 150, height: 310)
                            .onTapGesture {
                                navigationPath.push(.movieDetailView(movieId: movie.id))
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 8)
        }
    }
    
    @ViewBuilder
    func header() -> some View {
        HStack {
            Text(headerTitle)
                .font(.headline)
                .padding()
            
            Spacer()
            Button {
                moreButtonAction()
            } label: {
                Text("More")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.link)
            }
            .padding()
        }
    }
}

#Preview {
    MoviesCarousalView(headerTitle: "Now Playing", movies: Movie.sampleData_Multiples, moreButtonAction: {})
        
}
