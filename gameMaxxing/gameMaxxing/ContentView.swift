//
//  ContentView.swift
//  gameMaxxing
//
//  Created by Lalitya Muktineni on 4/8/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(GameStore.self) private var store

    var body: some View {
        if store.currentUser != nil {
            HomeView()
        } else {
            AuthView()
        }
    }
}

#Preview {
    ContentView()
        .environment(GameStore())
}
