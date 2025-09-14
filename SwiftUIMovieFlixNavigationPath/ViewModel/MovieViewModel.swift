//
//  MovieViewModel.swift
//  MovieFlixSwiftUI
//
//  Created by Angelos Staboulis on 15/9/25.
//

import Foundation
@MainActor
class MovieViewModel: ObservableObject {
       @Published var movies: [Movie] = []
       @Published var searchMovies: [Movie] = []
       @Published var isLoading = false
       @Published var errorMessage: String?
       @Published var searchText: String = ""

       let service: NetworkService

       init(service: NetworkService) {
           self.service = service
       }

       func loadPopularMovies() async {
           isLoading = true
           errorMessage = nil
           do {
               let results = try await service.fetchPopularMovies()
               movies = results
           } catch {
               errorMessage = "Could not fetch popular movies: \(error.localizedDescription)"
           }
           isLoading = false
       }

       func searchMovies() async {
           errorMessage = nil
           do {
               let results = try await service.searcbMovies(query: searchText)
               searchMovies = results
           } catch {
               errorMessage = "Search failed: \(error.localizedDescription)"
           }
       }
}
