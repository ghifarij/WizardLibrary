//
//  CharacterListView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharactersViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)
                        ], spacing: 12) {
                            ForEach(viewModel.characters) { character in
                                CharacterGridView(character: character)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Characters")
        }
        .onAppear {
            viewModel.fetchCharacters()
        }
    }
}


#Preview {
    let mockViewModel = CharactersViewModel(networkService: MockNetworkService())
    
    return CharacterListView()
        .environmentObject(mockViewModel)
}
