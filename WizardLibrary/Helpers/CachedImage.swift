//
//  CachedImage.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//


import SwiftUI
import Kingfisher

struct CachedImage<Content: View, Placeholder: View>: View {
    let url: URL?
    let content: (Image) -> Content
    let placeholder: () -> Placeholder
    
    @State private var useKingfisher = true
    
    init(
        url: URL?,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }
    
    var body: some View {
        Group {
            if useKingfisher, let url = url {
                KFImage(url)
                    .placeholder {
                        placeholder()
                    }
                    .retry(maxCount: 3, interval: .seconds(0.5))
                    .onFailure { error in
                        print("Kingfisher failed, falling back to AsyncImage: \(error)")
                        useKingfisher = false
                    }
                    .resizable()
            } else if let url = url {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        placeholder()
                    case .success(let image):
                        content(image)
                    case .failure:
                        placeholder()
                    @unknown default:
                        placeholder()
                    }
                }
            } else {
                placeholder()
            }
        }
    }
}
