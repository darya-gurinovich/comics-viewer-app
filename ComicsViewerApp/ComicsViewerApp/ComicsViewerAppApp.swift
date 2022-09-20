//
//  ComicsViewerAppApp.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 1.09.21.
//

import SwiftUI

@main
struct ComicsViewerAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                let comicsViewModel = ComicsViewModel(comicsSource: ComicsXkcdSource())
                
                ComicsListView(comicsViewModel: comicsViewModel)
            }
        }
    }
}
