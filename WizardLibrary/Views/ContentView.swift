//
//  ContentView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var booksVM = BooksViewModel()
    
    var body: some View {
        TabView {
            BookListView()
                .tabItem {
                    Label("Books", systemImage: "book")
                }
                .environmentObject(booksVM)
            
            CharacterListView()
                .tabItem {
                    Label("Characters", systemImage: "person")
                }
            
            MovieListView()
                .tabItem {
                    Label("Movies", systemImage: "camera")
                }
            
            PotionListView()
                .tabItem {
                    Label("Potions", systemImage: "flask")
                }
        }
    }
}

#Preview {
    ContentView()
}
