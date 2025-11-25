//
//  PotionListView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import SwiftUI

struct PotionListView: View {
    @StateObject private var viewModel = PotionsViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.potions.isEmpty {
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
                            ForEach(viewModel.potions) { potion in
                                PotionGridView(potion: potion)
                                    .onAppear {
                                        if potion.id == viewModel.potions.last?.id {
                                            viewModel.loadMorePotions()
                                        }
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Potions")
        }
        .onAppear {
            if viewModel.potions.isEmpty {
                viewModel.fetchPotions()
            }
        }
    }
}


#Preview {
    let mockViewModel = PotionsViewModel(networkService: MockNetworkService())
    
    return PotionListView()
        .environmentObject(mockViewModel)
}
