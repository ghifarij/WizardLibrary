//
//  ContentView.swift
//  WizardLibrary
//
//  Created by Afga Ghifari on 23/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BookListView()
                .tabItem {
                    Label("Books", systemImage: "book.circle")
                }
            
            CharacterListView()
                .tabItem {
                    Label("Characters", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
