//
//  SpellListView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import SwiftUI

struct SpellListView: View {
    @EnvironmentObject var viewModel: SpellsViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.spells.isEmpty {
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)
                        ], spacing: 12) {
                            ForEach(viewModel.spells) { spell in
                                SpellGridView(spell: spell)
                                    .onAppear {
                                        if spell.id == viewModel.spells.last?.id {
                                            viewModel.loadMoreSpells()
                                        }
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Spells")
            .onDisappear {
                viewModel.resetToFirstPage()
            }
        }
    }
}


#Preview {
    let mockViewModel = SpellsViewModel(networkService: MockNetworkService())
    
    return SpellListView()
        .environmentObject(mockViewModel)
}
