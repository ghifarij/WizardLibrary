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
                    ProgressView()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                } else {
                    List(viewModel.books) { book in
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .font(.headline)
                            if let author = book.author {
                                Text(author)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Books")
        }
    }
}

#Preview {
    let mockViewModel = BooksViewModel(networkService: MockNetworkService())
    
    return BookListView()
        .environmentObject(mockViewModel)
}
