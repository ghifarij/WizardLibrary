//
//  CharacterListView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import SwiftUI

struct CharacterListView: View {
    @EnvironmentObject var viewModel: CharactersViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.characters.isEmpty {
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                } else {
                    VStack(spacing: 12) {
                        HStack {
                            Text("Sort")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                            
                            Picker("Sort", selection: $viewModel.sortOption) {
                                ForEach(CharacterSortOption.allCases, id: \.self) { option in
                                    Text(option.title).tag(option)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        .padding(.horizontal)
                        
                        ScrollView {
                            LazyVGrid(columns: [
                                GridItem(.flexible(), spacing: 12),
                                GridItem(.flexible(), spacing: 12)
                            ], spacing: 12) {
                                ForEach(viewModel.sortedCharacters) { character in
                                    CharacterGridView(character: character)
                                        .onAppear {
                                            if character.id == viewModel.sortedCharacters.last?.id {
                                                viewModel.loadMoreCharacters()
                                            }
                                        }
                                }
                                .glassEffect(in: .rect(cornerRadius: 12.0))
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Characters")
            .onDisappear {
                viewModel.resetToFirstPage()
            }
        }
    }
}


#Preview {
    let mockViewModel = CharactersViewModel(networkService: MockNetworkService())
    
    return CharacterListView()
        .environmentObject(mockViewModel)
}
