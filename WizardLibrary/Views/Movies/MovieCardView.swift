//
//  MovieCardView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie

    private let cardHeight: CGFloat = 400
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Spacer()
                imageSection
                Spacer()
            }
            
            NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                HStack {
                    Text(movie.title)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .tint(.primary)
                    
                    Spacer()
                    
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.gray)
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: cardHeight)
    }
    
    @ViewBuilder
    private var imageSection: some View {
        CachedImage(
            url: movie.posterURL,
            content: { image in
                image
                    .resizable()
            },
            placeholder: {
                ZStack {
                    Color(.systemGray5)
                    Image(systemName: "photo")
                        .font(.system(size: 48))
                        .foregroundStyle(.gray)
                }
                .cornerRadius(12)
            }
        )
        .scaledToFit()
        .frame(width: .infinity)
        .padding(.top, 8)
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
