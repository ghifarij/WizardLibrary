//
//  PotionListView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import SwiftUI

struct PotionListView: View {
    @EnvironmentObject var viewModel: PotionsViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.potions.isEmpty {
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
                            ForEach(viewModel.potions) { potion in
                                PotionGridView(potion: potion)
                                    .onAppear {
                                        if potion.id == viewModel.potions.last?.id {
                                            viewModel.loadMorePotions()
                                        }
                                    }
                            }
                            .glassEffect(in: .rect(cornerRadius: 12.0))
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Potions")
            .onDisappear {
                viewModel.resetToFirstPage()
            }
        }
    }
}


#Preview {
    let mockViewModel = PotionsViewModel(networkService: MockNetworkService())
    
    return PotionListView()
        .environmentObject(mockViewModel)
}
