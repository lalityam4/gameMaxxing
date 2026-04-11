//
//  gameMaxxingApp.swift
//  gameMaxxing
//
//  Created by Lalitya Muktineni on 4/8/26.
//

import SwiftUI

@main
struct gameMaxxingApp: App {
    @State private var store = GameStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
                .onAppear {
                    store.restoreSession()
                }
        }
    }
}
