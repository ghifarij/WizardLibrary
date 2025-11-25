//
//  PotionDetailView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import SwiftUI

struct PotionDetailView: View {
    let potionId: String
    
    private let imageHeight: CGFloat = 300
    
    @StateObject private var viewModel = PotionsViewModel()
    
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
            } else if let potion = viewModel.selectedPotion {
                VStack(alignment: .leading, spacing: 0) {
                    // Potion Image
                    if let imageURL = potion.imageURL, let url = URL(string: imageURL) {
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
                        Image(systemName: "flask.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // Name
                        Text(potion.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        Divider()
                        
                        // Effect
                        if let effect = potion.effect {
                            DetailSection(title: "Effect", content: effect)
                            Divider()
                        }
                        
                        // Characteristics
                        if let characteristics = potion.characteristics {
                            DetailSection(title: "Characteristics", content: characteristics)
                            Divider()
                        }
                        
                        // Difficulty
                        if let difficulty = potion.difficulty {
                            DetailSection(title: "Difficulty", content: difficulty)
                            Divider()
                        }
                        
                        // Brewing Time
                        if let time = potion.time {
                            DetailSection(title: "Brewing Time", content: time)
                            Divider()
                        }
                        
                        // Ingredients
                        if let ingredients = potion.ingredients {
                            DetailSection(title: "Ingredients", content: ingredients)
                            Divider()
                        }
                        
                        // Side Effects
                        if let sideEffects = potion.sideEffects {
                            DetailSection(title: "Side Effects", content: sideEffects)
                            Divider()
                        }
                        
                        // Inventors
                        if let inventors = potion.inventors {
                            DetailSection(title: "Inventors", content: inventors)
                            Divider()
                        }
                        
                        // Manufacturers
                        if let manufacturers = potion.manufacturers {
                            DetailSection(title: "Manufacturers", content: manufacturers)
                            Divider()
                        }
                        
                        // Wiki Link
                        if let wikiURLString = potion.wiki, let wikiURL = URL(string: wikiURLString) {
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
        .navigationTitle("Potion Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchPotion(id: potionId)
        }
    }
}

#Preview {
    let mockViewModel = PotionsViewModel(networkService: MockNetworkService())
    
    PotionDetailView(potionId: "some-potion-id")
        .environmentObject(mockViewModel)
}
