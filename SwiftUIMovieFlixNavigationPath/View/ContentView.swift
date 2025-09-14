//
//  ContentView.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 15/9/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: MovieViewModel
    @State  var path = NavigationPath()
    @State var isSearching:Bool
    init(apiKey: String,isSearching:Bool) {
        _viewModel = StateObject(wrappedValue: MovieViewModel(service: NetworkService(apiKey: apiKey)))
        self.isSearching = isSearching
    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                // MARK: Search bar
                HStack {
                    TextField("Search movies...", text: $viewModel.searchText, onCommit: {
                        Task {
                            isSearching = true
                            await viewModel.searchMovies()
                        }
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                    Button("Search") {
                        Task {
                            isSearching = true
                            await viewModel.searchMovies()
                        }
                    }
                    .padding(.trailing)
                }
                .padding(.top)

                // MARK: List / Results
                if viewModel.isLoading {
                    ProgressView("Loading…")
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                        Button("Retry") {
                            Task {
                                if viewModel.searchText.isEmpty {
                                    await viewModel.loadPopularMovies()
                                } else {
                                    isSearching = true
                                    await viewModel.searchMovies()
                                }
                            }
                        }
                    }
                    Spacer()
                } else {
                    List(isSearching ? viewModel.searchMovies : viewModel.movies) { movie in
                        Button {
                            path.append(movie)
                        } label: {
                            MovieRowview(movie: movie)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movieId: movie.id, service: viewModel.service)
            }
        }
        .task {
            await viewModel.loadPopularMovies()
        }
    }
        
}

