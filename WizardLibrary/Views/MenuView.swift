//
//  MenuView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 25/11/25.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var booksVM: BooksViewModel
    @EnvironmentObject var charactersVM: CharactersViewModel
    @EnvironmentObject var moviesVM: MoviesViewModel
    @EnvironmentObject var potionsVM: PotionsViewModel
    @EnvironmentObject var spellsVM: SpellsViewModel
    
    struct CategoryItem: Identifiable {
        let id = UUID()
        let systemImage: String
        let title: String
        let color: Color
        let destination: AnyView
    }
    
    var categories: [CategoryItem] {
        [
            CategoryItem(
                systemImage: "book",
                title: "Books",
                color: .brown,
                destination: AnyView(BookListView().environmentObject(booksVM))
            ),
            CategoryItem(
                systemImage: "person",
                title: "Characters",
                color: .purple,
                destination: AnyView(CharacterListView().environmentObject(charactersVM))
            ),
            CategoryItem(
                systemImage: "camera",
                title: "Movies",
                color: .red,
                destination: AnyView(MovieListView().environmentObject(moviesVM))
            ),
            CategoryItem(
                systemImage: "flask",
                title: "Potions",
                color: .green,
                destination: AnyView(PotionListView().environmentObject(potionsVM))
            ),
            CategoryItem(
                systemImage: "wand.and.sparkles",
                title: "Spells",
                color: .blue,
                destination: AnyView(SpellListView().environmentObject(spellsVM))
            )
        ]
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                ForEach(categories) { category in
                    NavigationLink(destination: category.destination) {
                        HStack(spacing: 16) {
                            Image(systemName: category.systemImage)
                                .font(.title2)
                                .foregroundStyle(category.color)
                                .frame(width: 30)
                            
                            Text(category.title)
                                .font(.headline)
                                .tint(.primary)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .tint(.gray)
                        }
                    }
                    .padding()
                    .glassEffect()
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Menu")
        }
    }
}

#Preview {
    MenuView()
        .environmentObject(BooksViewModel())
        .environmentObject(CharactersViewModel())
        .environmentObject(MoviesViewModel())
        .environmentObject(PotionsViewModel())
        .environmentObject(SpellsViewModel())
}
