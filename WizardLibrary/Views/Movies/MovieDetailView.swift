//
//  MovieDetailView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import SwiftUI

struct MovieDetailView: View {
    let movieId: String
    @StateObject private var viewModel = MoviesViewModel()
    
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
            } else if let movie = viewModel.selectedMovie {
                VStack(alignment: .leading, spacing: 0) {
                    // Movie Poster
                    if let posterURL = movie.posterURL {
                        CachedImage(
                            url: posterURL,
                            content: { image in
                                image
                                    .resizable()
                            },
                            placeholder: {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 400)
                            }
                        )
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                    } else {
                        Image(systemName: "film.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: 400)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        // Title
                        Text(movie.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        Divider()
                        
                        // Summary
                        if let summary = movie.summary {
                            DetailSection(title: "Summary", content: summary)
                            Divider()
                        }
                        
                        // Release Info
                        if let releaseDate = movie.releaseDate {
                            DetailSection(title: "Release Date", content: releaseDate)
                            Divider()
                        }
                        
                        if let runningTime = movie.runningTime {
                            DetailSection(title: "Running Time", content: runningTime)
                            Divider()
                        }
                        
                        if let rating = movie.rating {
                            DetailSection(title: "Rating", content: rating)
                            Divider()
                        }
                        
                        // Financial Info
                        if let budget = movie.budget {
                            DetailSection(title: "Budget", content: budget)
                            Divider()
                        }
                        
                        if let boxOffice = movie.boxOffice {
                            DetailSection(title: "Box Office", content: boxOffice)
                            Divider()
                        }
                        
                        // Crew
                        if let directors = movie.directors, !directors.isEmpty {
                            DetailSection(title: "Directors", content: directors.joined(separator: ", "))
                            Divider()
                        }
                        
                        if let producers = movie.producers, !producers.isEmpty {
                            DetailSection(title: "Producers", content: producers.joined(separator: ", "))
                            Divider()
                        }
                        
                        if let screenwriters = movie.screenwriters, !screenwriters.isEmpty {
                            DetailSection(title: "Screenwriters", content: screenwriters.joined(separator: ", "))
                            Divider()
                        }
                        
                        if let cinematographers = movie.cinematographers, !cinematographers.isEmpty {
                            DetailSection(title: "Cinematographers", content: cinematographers.joined(separator: ", "))
                            Divider()
                        }
                        
                        if let editors = movie.editors, !editors.isEmpty {
                            DetailSection(title: "Editors", content: editors.joined(separator: ", "))
                            Divider()
                        }
                        
                        if let musicComposers = movie.musicComposers, !musicComposers.isEmpty {
                            DetailSection(title: "Music Composers", content: musicComposers.joined(separator: ", "))
                            Divider()
                        }
                        
                        // Distribution
                        if let distributors = movie.distributors, !distributors.isEmpty {
                            DetailSection(title: "Distributors", content: distributors.joined(separator: ", "))
                            Divider()
                        }
                        
                        // Links
                        if let trailerURL = movie.trailerURL {
                            Link(destination: trailerURL) {
                                HStack {
                                    Text("Watch Trailer")
                                        .font(.headline)
                                    Image(systemName: "play.circle.fill")
                                }
                                .foregroundColor(.blue)
                            }
                            Divider()
                        }
                        
                        if let wikiURL = movie.wikiURL {
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
        .navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchMovie(id: movieId)
        }
    }
}

#Preview {
    let mockViewModel = MoviesViewModel(networkService: MockNetworkService())
    
    MovieDetailView(movieId: "406c41c1-babd-4ead-9567-9783c1742d39")
        .environmentObject(mockViewModel)
}
