//
//  SpellDetailView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import SwiftUI

struct SpellDetailView: View {
    let spellId: String
    
    private let imageHeight: CGFloat = 300
    
    @StateObject private var viewModel = SpellsViewModel()
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Text(errorMessage)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .padding()
            } else if let spell = viewModel.selectedSpell {
                VStack(alignment: .leading, spacing: 0) {
                    // Spell Image
                    if let imageURL = spell.imageURL, let url = URL(string: imageURL) {
                        HStack {
                            Spacer()
                            CachedImage(
                                url: url,
                                content: { image in
                                    image
                                        .resizable()
                                },
                                placeholder: {
                                    ProgressView()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 300)
                                }
                            )
                            .scaledToFit()
                            .frame(width: .infinity, height: imageHeight)
                            
                            Spacer()
                        }
                    } else {
                        Image(systemName: "wand.and.stars")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // Name
                        Text(spell.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        Divider()
                        
                        // Incantation
                        if let incantation = spell.incantation {
                            DetailSection(title: "Incantation", content: incantation)
                            Divider()
                        }
                        
                        // Effect
                        if let effect = spell.effect {
                            DetailSection(title: "Effect", content: effect)
                            Divider()
                        }
                        
                        // Category
                        if let category = spell.category {
                            DetailSection(title: "Category", content: category)
                            Divider()
                        }
                        
                        // Light
                        if let light = spell.light {
                            DetailSection(title: "Light", content: light)
                            Divider()
                        }
                        
                        // Hand
                        if let hand = spell.hand {
                            DetailSection(title: "Hand", content: hand)
                            Divider()
                        }
                        
                        // Creator
                        if let creator = spell.creator {
                            DetailSection(title: "Creator", content: creator)
                            Divider()
                        }
                        
                        // Wiki Link
                        if let wikiURLString = spell.wiki, let wikiURL = URL(string: wikiURLString) {
                            Link(destination: wikiURL) {
                                HStack {
                                    Text("View on Wiki")
                                        .font(.headline)
                                    Image(systemName: "link.circle.fill")
                                }
                                .foregroundColor(.blue)
                            }
                            Divider()
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Spell Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchSpell(id: spellId)
        }
    }
}

#Preview {
    let mockViewModel = SpellsViewModel(networkService: MockNetworkService())
    
    SpellDetailView(spellId: "317623dc-33c9-4876-957d-07d793fb689a")
        .environmentObject(mockViewModel)
}
