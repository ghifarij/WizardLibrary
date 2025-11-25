//
//  MovieListView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MoviesViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.movies.isEmpty {
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
                            ForEach(viewModel.movies) { movie in
                                MovieCardView(movie: movie)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Movies")
        }
        .onAppear {
            if viewModel.movies.isEmpty {
                viewModel.fetchMovies()
            }
        }
    }
}

#Preview {
    let mockViewModel = MoviesViewModel(networkService: MockNetworkService())
    
    MovieListView()
        .environmentObject(mockViewModel)
}
