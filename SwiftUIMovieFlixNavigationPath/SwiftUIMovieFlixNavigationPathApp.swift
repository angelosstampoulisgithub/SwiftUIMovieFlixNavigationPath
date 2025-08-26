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
            ContentView(movieTitle: "", popularState: .init(), searchResults: [])
             
        }
    }
}
