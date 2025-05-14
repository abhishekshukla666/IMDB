//
//  PMAsyncImage.swift
//  IMDB
//
//  Created by Abhishek Shukla on 05/05/25.
//

import SwiftUI

struct LazyAsyncImage: View {
    let imageURL: String
    let loaderOffset: CGSize
    let imageOffset: CGSize
    let contentMode: ContentMode
    
    init(imageURL: String, loaderOffset: CGSize = .zero, imageOffset: CGSize = .zero, contentMode: ContentMode = .fill) {
        self.imageURL = imageURL
        self.loaderOffset = loaderOffset
        self.imageOffset = imageOffset
        self.contentMode = contentMode
    }
    
    var modifiedImageURL: String {
        "https://image.tmdb.org/t/p/w500\(imageURL)"
    }
    
    var body: some View {
        ZStack {
            CachedImage(imageURL: modifiedImageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .tint(apptint)
                        .offset(loaderOffset)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                        .offset(imageOffset)
                case .failure:
                    Image(systemName: "movieclapper")
                        .resizable()
                        .scaledToFit()
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}



#Preview {
    LazyAsyncImage(imageURL: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg")
        .frame(height: 88)
}
