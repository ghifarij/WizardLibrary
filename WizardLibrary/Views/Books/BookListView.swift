//
//  BookListView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import SwiftUI

struct BookListView: View {
    @EnvironmentObject var viewModel: BooksViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
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
                            ForEach(viewModel.books) { book in
                                BookCardView(book: book)
                            }
                            .glassEffect(in: .rect(cornerRadius: 12.0))
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Books")
        }
    }
}

#Preview {
    let mockViewModel = BooksViewModel(networkService: MockNetworkService())
    
    return BookListView()
        .environmentObject(mockViewModel)
}
