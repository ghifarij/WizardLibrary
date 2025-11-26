//
//  BookCardView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import SwiftUI

struct BookCardView: View {
    let book: Book
    
    private let cardHeight: CGFloat = 400
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Spacer()
                imageSection
                Spacer()
            }
            
            NavigationLink(destination: BookDetailView(bookId: book.id)) {
                HStack {
                    Text(book.title)
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
            url: book.coverURL,
            content: { image in
                image
                    .resizable()
            },
            placeholder: {
                ZStack {
                    Color(.systemGray5)
                    Image(systemName: "book.closed")
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
    let mockBook = Book(
        id: "1",
        title: "Harry Potter and the Philosopher's Stone",
        author: "J.K. Rowling",
        summary: "The first book in the series...",
        pages: 223,
        releaseDate: "1997-06-26",
        coverURL: nil
    )
    
    BookCardView(book: mockBook)
}
