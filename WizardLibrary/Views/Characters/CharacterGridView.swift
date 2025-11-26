//
//  CharacterGridView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import SwiftUI

struct CharacterGridView: View {
    let character: Character
    
    private let imageHeight: CGFloat = 200
    private let cardHeight: CGFloat = 250
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Spacer()
                imageSection
                Spacer()
            }
            
            NavigationLink(destination: CharacterDetailView(characterId: character.id)) {
                HStack {
                    Text(character.name)
                        .font(.caption)
                        .lineLimit(1)
                        .tint(.primary)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: cardHeight)
    }
    
    @ViewBuilder
    private var imageSection: some View {
        let url = character.imageURL.flatMap { URL(string: $0) }
        
        CachedImage(
            url: url,
            content: { image in
                image
                    .resizable()
            },
            placeholder: {
                ZStack {
                    Color(.systemGray5)
                    Image(systemName: "photo")
                        .font(.system(size: 48))
                        .foregroundStyle(.gray)
                }
                .cornerRadius(12)
            }
        )
        .scaledToFit()
        .frame(width: .infinity, height: imageHeight)
        .padding(.top, 8)
    }
}
