//
//  CharacterDetailView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let characterId: String
    @StateObject private var viewModel = CharactersViewModel()
    
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
            } else if let character = viewModel.selectedCharacter {
                VStack(alignment: .leading, spacing: 0) {
                    // Character Image
                    if let imageURL = character.imageURL, let url = URL(string: imageURL) {
                        CachedImage(
                            url: url,
                            content: { image in
                                image
                                    .resizable()
                            },
                            placeholder: {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 200)
                            }
                        )
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding()
                    } else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // Name
                        Text(character.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        Divider()
                        
                        // Alias Names
                        if let aliasNames = character.aliasNames, !aliasNames.isEmpty {
                            DetailSection(title: "Alias Names", content: aliasNames.joined(separator: ", "))
                            Divider()
                        }
                        
                        // Basic Info
                        if let species = character.species {
                            DetailSection(title: "Species", content: species)
                            Divider()
                        }
                        
                        if let gender = character.gender {
                            DetailSection(title: "Gender", content: gender)
                            Divider()
                        }
                        
                        if let house = character.house {
                            DetailSection(title: "House", content: house)
                            Divider()
                        }
                        
                        if let bloodStatus = character.bloodStatus {
                            DetailSection(title: "Blood Status", content: bloodStatus)
                            Divider()
                        }
                        
                        // Birth & Death
                        if let born = character.born {
                            DetailSection(title: "Born", content: born)
                            Divider()
                        }
                        
                        if let died = character.died {
                            DetailSection(title: "Died", content: died)
                            Divider()
                        }
                        
                        if let nationality = character.nationality {
                            DetailSection(title: "Nationality", content: nationality)
                            Divider()
                        }
                        
                        // Physical Attributes
                        if let height = character.height {
                            DetailSection(title: "Height", content: height)
                            Divider()
                        }
                        
                        if let weight = character.weight {
                            DetailSection(title: "Weight", content: weight)
                            Divider()
                        }
                        
                        if let eyeColor = character.eyeColor {
                            DetailSection(title: "Eye Color", content: eyeColor)
                            Divider()
                        }
                        
                        if let hairColor = character.hairColor {
                            DetailSection(title: "Hair Color", content: hairColor)
                            Divider()
                        }
                        
                        if let skinColor = character.skinColor {
                            DetailSection(title: "Skin Color", content: skinColor)
                            Divider()
                        }
                        
                        // Magical Attributes
                        if let patronus = character.patronus {
                            DetailSection(title: "Patronus", content: patronus)
                            Divider()
                        }
                        
                        if let boggart = character.boggart {
                            DetailSection(title: "Boggart", content: boggart)
                            Divider()
                        }
                        
                        if let animagus = character.animagus {
                            DetailSection(title: "Animagus", content: animagus)
                            Divider()
                        }
                        
                        if let wand = character.wand, !wand.isEmpty {
                            DetailSection(title: "Wand", content: wand.joined(separator: ", "))
                            Divider()
                        }
                        
                        // Titles & Jobs
                        if let titles = character.titles, !titles.isEmpty {
                            DetailSection(title: "Titles", content: titles.joined(separator: ", "))
                            Divider()
                        }
                        
                        if let jobs = character.jobs, !jobs.isEmpty {
                            DetailSection(title: "Jobs", content: jobs.joined(separator: ", "))
                            Divider()
                        }
                        
                        // Family & Relationships
                        if let familyMembers = character.familyMembers, !familyMembers.isEmpty {
                            DetailSection(title: "Family Members", content: familyMembers.joined(separator: ", "))
                            Divider()
                        }
                        
                        if let romances = character.romances, !romances.isEmpty {
                            DetailSection(title: "Romances", content: romances.joined(separator: ", "))
                            Divider()
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Character Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchCharacter(id: characterId)
        }
    }
}

struct DetailSection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    let mockViewModel = CharactersViewModel(networkService: MockNetworkService())
    
    CharacterDetailView(characterId: "db55dcdb-f5c8-4236-bd61-f3bb8768c0ef")
        .environmentObject(mockViewModel)
}
