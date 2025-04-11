//
//  SwiftUIMovieFlixNavigationPathApp.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 10/4/25.
//

import SwiftUI

@main
struct SwiftUIMovieFlixNavigationPathApp: App {
    @StateObject var viewModel = MovieListViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(movieTitle: "", isHeart: false, isShowingDetailView: 0, getSelected: .init(backdrop_path: "", id: 0, release_date: "", title: "", vote_average: 0.0, vote_count: 0))
                .environmentObject(viewModel)
        }
    }
}
