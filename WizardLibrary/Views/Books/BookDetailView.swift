//
//  BookDetailView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import SwiftUI

struct BookDetailView: View {
    @EnvironmentObject var viewModel: BooksViewModel
    let bookId: String
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundStyle(.red)
                    Text(error)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                }
                .padding()
            } else if let book = viewModel.selectedBook {
                VStack(alignment: .leading, spacing: 0) {
                    // Book Cover
                    HStack {
                        Spacer()
                        if let coverURL = book.coverURL {
                            CachedImage(
                                url: coverURL,
                                content: { image in
                                    image
                                        .resizable()
                                },
                                placeholder: {
                                    ProgressView()
                                }
                            )
                            .scaledToFit()
                            .frame(width: .infinity)
                            .padding()
                        }
                        Spacer()
                    }
                    
                    // Book Details
                    VStack(alignment: .leading, spacing: 12) {
                        Text(book.title)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        if let author = book.author {
                            Label(author, systemImage: "person.fill")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            if let pages = book.pages {
                                Label("\(pages) pages", systemImage: "book.fill")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            if let releaseDate = book.releaseDate {
                                Label(releaseDate, systemImage: "calendar")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        if let summary = book.summary {
                            Text(summary)
                                .font(.body)
                                .padding(.top, 8)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Chapters Section
                    if !viewModel.chapters.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Chapters")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            ForEach(viewModel.chapters) { chapter in
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        if let order = chapter.order {
                                            Text("\(order).")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                                .frame(width: 30, alignment: .leading)
                                        }
                                        
                                        Text(chapter.title)
                                            .font(.headline)
                                    }
                                    
                                    if let summary = chapter.summary {
                                        Text(summary)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .padding(.leading, chapter.order != nil ? 30 : 0)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                
                                if chapter.id != viewModel.chapters.last?.id {
                                    Divider()
                                        .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.top)
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationTitle("Book Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchBook(id: bookId)
        }
        .onDisappear {
            viewModel.clearSelectedBook()
        }
    }
}

#Preview {
    let mockViewModel = BooksViewModel(networkService: MockNetworkService())
    
    return NavigationStack {
        BookDetailView(bookId: "76040954-a2ea-45bc-a058-6d2d9f6d71ea")
            .environmentObject(mockViewModel)
    }
}
