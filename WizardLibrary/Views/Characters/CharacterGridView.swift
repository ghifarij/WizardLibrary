//
//  CharacterGridView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import SwiftUI

struct CharacterGridView: View {
    let character: Character
    
    private let imageHeight: CGFloat = 150
    private let imageWidth: CGFloat = 150
    private let cardHeight: CGFloat = 200
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            imageSection
            
            Text(character.name)
                .font(.caption)
                .lineLimit(1)
                .padding(.horizontal)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: cardHeight)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private var imageSection: some View {
        let url = character.imageURL.flatMap { URL(string: $0) }
        
        CachedImage(
            url: url,
            content: { image in
                image
                    .resizable()
                    .scaledToFill()
            },
            placeholder: {
                ZStack {
                    Color(.systemGray5)
                    Image(systemName: "photo")
                        .font(.system(size: 48))
                        .foregroundStyle(.gray)
                }
            }
        )
        .frame(width: .infinity, height: imageHeight)
        .clipped()
    }
}
