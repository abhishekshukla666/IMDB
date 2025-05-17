//
//  CloudView.swift
//  IMDB
//
//  Created by Abhishek Shukla on 17/05/25.
//

import SwiftUI

struct CloudView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    var data: Data
    var spacing: CGFloat = 8
    var content: (Data.Element) -> Content

    @State private var totalHeight: CGFloat = .zero

    var body: some View {
        GeometryReader { geo in
            self.generateContent(in: geo)
        }
        .frame(height: totalHeight)
    }

    private func generateContent(in geo: GeometryProxy) -> some View {
        var width: CGFloat = 0
        var height: CGFloat = 0

        return ZStack(alignment: .topLeading) {
            ForEach(Array(data), id: \.self) { item in
                content(item)
                    .padding([.horizontal, .vertical], 8)
                    .background(Capsule().fill(Color.blue.opacity(0.2)))
                    .alignmentGuide(.leading, computeValue: { d in
                        if abs(width - d.width) > geo.size.width {
                            width = 0
                            height -= d.height + spacing
                        }
                        let result = width
                        if item == data.last {
                            DispatchQueue.main.async {
                                self.totalHeight = abs(height) + d.height
                            }
                        }
                        width -= d.width + spacing
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        return result
                    })
            }
        }
    }
}

struct CloudTagExampleView: View {
    let tags = [
        "Swift", "SwiftUI", "Xcode", "iOS", "macOS", "CloudKit",
        "Combine", "Core Data", "UIKit", "Async/Await", "Actors"
    ]

    var body: some View {
        ScrollView {
            CloudView(data: tags) { tag in
                Text(tag)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Capsule().fill(Color.blue))
            }
            .padding()
        }
        .navigationTitle("Tech Cloud")
    }
}

#Preview {
    NavigationView {
        CloudTagExampleView()
    }

}
