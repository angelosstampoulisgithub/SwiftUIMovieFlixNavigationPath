//
//  SwiftUIMovieFlixNavigationPathApp.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 10/4/25.
//

import SwiftUI

@main
struct SwiftUIMovieFlixNavigationPathApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(movieTitle: "", isSearching: false, popularState: .init(), searchResults: [], movieID: 0)
             
        }
    }
}
