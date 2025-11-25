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
        let destination: AnyView
    }
    
    var categories: [CategoryItem] {
        [
            CategoryItem(
                systemImage: "book",
                title: "Books",
                destination: AnyView(BookListView().environmentObject(booksVM))
            ),
            CategoryItem(
                systemImage: "person",
                title: "Characters",
                destination: AnyView(CharacterListView().environmentObject(charactersVM))
            ),
            CategoryItem(
                systemImage: "camera",
                title: "Movies",
                destination: AnyView(MovieListView().environmentObject(moviesVM))
            ),
            CategoryItem(
                systemImage: "flask",
                title: "Potions",
                destination: AnyView(PotionListView().environmentObject(potionsVM))
            ),
            CategoryItem(
                systemImage: "wand.and.sparkles",
                title: "Spells",
                destination: AnyView(SpellListView().environmentObject(spellsVM))
            )
        ]
    }
    
    var body: some View {
        NavigationStack {
            List(categories) { category in
                NavigationLink(destination: category.destination) {
                    HStack(spacing: 16) {
                        Image(systemName: category.systemImage)
                            .font(.title2)
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        
                        Text(category.title)
                            .font(.headline)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Menu")
        }
    }
}

#Preview {
    MenuView()
        .environmentObject(BooksViewModel())
}
