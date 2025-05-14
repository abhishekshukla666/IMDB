//
//  VHView.swift
//  IMDB
//
//  Created by Abhishek Shukla on 06/05/25.
//

import SwiftUI

protocol NoViewBuilderProtocol {
    associatedtype Body: View
    @ViewBuilder var body: Body { get }
}

struct ViewBuilderExample: NoViewBuilderProtocol {
    
    let isHidden: Bool
    var body: some View {
        if isHidden {
           Text("Hidden")
        } else {
            Button("Visible") {
                
            }
        }
    }
}

struct VHStackView<Content: View>: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack(content: content)
        } else {
            HStack(content: content)
        }
    }
}

struct VHStackView_Preview: PreviewProvider {
    static var previews: some View {
        VHStackView {
            Text("Hello, there!")
            Text("I am a preview")
        }
    }
}
