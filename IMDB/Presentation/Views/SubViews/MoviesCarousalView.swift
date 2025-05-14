//
//  NowPlayingView.swift
//  IMDB
//
//  Created by Abhishek Shukla on 06/05/25.
//

import SwiftUI

struct MoviesCarousalView: View {
    
    let headerTitle: String
    let movies: [Movie]
    
    let moreButtonAction: () -> Void
    
    var body: some View {
        Section(header:
                    header()
        ) {
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, pinnedViews: [.sectionHeaders]) {
                    ForEach(movies) { nowPlayingMovie in
                        NowPlayingCardView(nowPlayingMovie: nowPlayingMovie)
                            .frame(width: 150, height: 310)
                        
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
            
            Spacer()
            Button {
                moreButtonAction()
            } label: {
                Text("More")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.link)
            }
            
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    MoviesCarousalView(headerTitle: "Now Playing", movies: Movie.sampleData_Multiples, moreButtonAction: {})
        
}
