//
//  ContentView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var booksVM = BooksViewModel()
    @StateObject var charactersVM = CharactersViewModel()
    @StateObject var moviesVM = MoviesViewModel()
    @StateObject var potionsVM = PotionsViewModel()
    @StateObject var spellsVM = SpellsViewModel()
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Today", systemImage: "star.fill")
                }
                .environmentObject(booksVM)
                .environmentObject(moviesVM)
            
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "square.grid.2x2.fill")
                }
                .environmentObject(booksVM)
                .environmentObject(charactersVM)
                .environmentObject(moviesVM)
                .environmentObject(potionsVM)
                .environmentObject(spellsVM)
        }
        .onAppear {
            if booksVM.books.isEmpty { booksVM.fetchBooks() }
            if charactersVM.characters.isEmpty { charactersVM.fetchCharacters() }
            if moviesVM.movies.isEmpty { moviesVM.fetchMovies() }
            if potionsVM.potions.isEmpty { potionsVM.fetchPotions() }
            if spellsVM.spells.isEmpty { spellsVM.fetchSpells() }
        }
    }
}

#Preview {
    ContentView()
}
