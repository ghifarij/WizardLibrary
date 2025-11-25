//
//  HomeView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var booksVM: BooksViewModel
    @EnvironmentObject var moviesVM: MoviesViewModel
    @State private var randomRecommendation: Recommendation?
    
    enum Recommendation {
        case book(Book)
        case movie(Movie)
        
        var title: String {
            switch self {
            case .book(let book):
                return "Book: \(book.title)"
            case .movie(let movie):
                return "Movie: \(movie.title)"
            }
        }
        
        var imageURL: URL? {
            switch self {
            case .book(let book):
                return book.coverURL
            case .movie(let movie):
                return movie.posterURL
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if booksVM.isLoading || moviesVM.isLoading {
                    VStack{
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                } else if let recommendation = randomRecommendation {
                    VStack(spacing: 16) {
                        if let imageURL = recommendation.imageURL {
                            CachedImage(
                                url: imageURL,
                                content: { image in
                                    image
                                        .resizable()
                                },
                                placeholder: {
                                    VStack{
                                        Spacer()
                                        ProgressView()
                                        Spacer()
                                    }
                                }
                            )
                            .scaledToFit()
                            .frame(width: .infinity, height: 500)
                            .padding()
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 500)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Text(recommendation.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Today's Recommendations")
            .onAppear {
                loadDataIfNeeded()
            }
        }
    }
    
    private func loadDataIfNeeded() {
        if booksVM.books.isEmpty {
            booksVM.fetchBooks()
        }
        if moviesVM.movies.isEmpty {
            moviesVM.fetchMovies()
        }
        
        // Wait a bit for data to load, then generate recommendation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if randomRecommendation == nil {
                generateRandomRecommendation()
            }
        }
    }
    
    private func generateRandomRecommendation() {
        let allItems: [Recommendation] =
            booksVM.books.map { .book($0) } +
            moviesVM.movies.map { .movie($0) }
        
        randomRecommendation = allItems.randomElement()
    }
}

#Preview {
    HomeView()
        .environmentObject(BooksViewModel())
        .environmentObject(MoviesViewModel())
}
