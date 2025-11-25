//
//  PotionGridView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import SwiftUI

struct PotionGridView: View {
    let potion: Potion
    
    private let imageHeight: CGFloat = 200
    private let cardHeight: CGFloat = 250
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Spacer()
                imageSection
                Spacer()
            }
            
            HStack {
                Text(potion.name)
                    .font(.caption)
                    .lineLimit(1)
                    .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    //TODO: Navigate to PotionDetail
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
        let url = potion.imageURL.flatMap { URL(string: $0) }
        
        CachedImage(
            url: url,
            content: { image in
                image
                    .resizable()
            },
            placeholder: {
                ZStack {
                    Color(.systemGray5)
                    Image(systemName: "flask")
                        .font(.system(size: 48))
                        .foregroundStyle(.gray)
                }
                .cornerRadius(12)
            }
        )
        .scaledToFit()
        .frame(width: .infinity, height: imageHeight)
    }
}
