//
//  SpellGridView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import SwiftUI

struct SpellGridView: View {
    let spell: Spell
    
    private let imageHeight: CGFloat = 200
    private let imageWidth: CGFloat = 150
    private let cardHeight: CGFloat = 250
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            imageSection
            
            HStack {
                Text(spell.name)
                    .font(.caption)
                    .lineLimit(1)
                    .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    //TODO: Navigate to SpellDetail
                }) {
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: cardHeight)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private var imageSection: some View {
        let url = spell.imageURL.flatMap { URL(string: $0) }
        
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
                    Image(systemName: "wand.and.stars")
                        .font(.system(size: 48))
                        .foregroundStyle(.gray)
                }
            }
        )
        .frame(width: .infinity, height: imageHeight)
        .clipped()
    }
}
