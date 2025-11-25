//
//  ContentView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var booksVM = BooksViewModel()
    @StateObject var moviesVM = MoviesViewModel()
    
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
        }
    }
}

#Preview {
    ContentView()
}
