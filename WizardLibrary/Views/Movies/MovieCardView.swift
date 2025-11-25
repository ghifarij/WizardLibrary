//
//  MovieCardView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie
    
    private let cardHeight: CGFloat = 500
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            imageSection
            
            Spacer()
            
            HStack {
                Text(movie.title)
                    .font(.body)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .padding(.horizontal)
                
                Spacer()
                
                NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: cardHeight)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private var imageSection: some View {
        CachedImage(
            url: movie.posterURL,
            content: { image in
                image
                    .resizable()
                    .scaledToFill()
            },
            placeholder: {
                ZStack {
                    Color(.systemGray5)
                    Image(systemName: "photo")
                        .font(.system(size: 48))
                        .foregroundStyle(.gray)
                }
                .padding()
                .cornerRadius(12)
            }
        )
        .scaledToFit()
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    let mockMovie = Movie(
        id: "1",
        boxOffice: "$974.8 million",
        budget: "$125 million",
        cinematographers: ["John Seale"],
        directors: ["Chris Columbus"],
        distributors: ["Warner Bros."],
        editors: ["Richard Francis-Bruce"],
        musicComposers: ["John Williams"],
        posterURL: nil,
        producers: ["David Heyman"],
        rating: "PG",
        releaseDate: "2001-11-16",
        runningTime: "152 minutes",
        screenwriters: ["Steve Kloves"],
        slug: "philosophers-stone",
        summary: "An orphaned boy enrolls in a school of wizardry...",
        title: "Harry Potter and the Philosopher's Stone",
        trailerURL: nil,
        wikiURL: nil
    )
    
    MovieCardView(movie: mockMovie)
}
