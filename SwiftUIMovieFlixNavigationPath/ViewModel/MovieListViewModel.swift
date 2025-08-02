//
//  MovieListViewModel.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 8/1/25.
//

import Foundation
import SwiftUI
@MainActor
class MovieListViewModel:ObservableObject {
    
    private var manager = NetworkManager()
    
    @Published var searchResults:[MovieListResultsModel] = []
    @Published var popularMovies: [MovieListResultsModel] = []
    @Published var similarMoviesArray:[MovieDetailModel]=[]
    init(manager: NetworkManager = NetworkManager(), searchResults: [MovieListResultsModel], popularMovies: [MovieListResultsModel], similarMoviesArray: [MovieDetailModel], favoriteMovies: [Int]) {
        self.manager = manager
        self.searchResults = searchResults
        self.popularMovies = popularMovies
        self.similarMoviesArray = similarMoviesArray
    }
    func fetchSearchResults(for query: String) {
        searchResults = popularMovies.filter { product in
            product.title!
                .contains(query)
        }
    }
    func fetchPopularMovies(isLoading:Bool) {
            Task{
                guard let movies = try await manager.fetchMovieList().results else{
                    return
                }
                for movie in 0..<movies.count{
                    popularMovies.append(movies[movie])
                }
            }
    }
    func fethMovieDetails(id:Int) async throws -> MovieDetailModel {
        
        return try await manager.fetchMovieDetails(with: id)
    }
    func fetchSimilarMovies(id:Int) async throws {
        Task{
            if similarMoviesArray.count >  0{
                similarMoviesArray.removeAll()
                guard let similarMovies = try await manager.fetchSimilarMovies(with: id).results else{
                    return
                }
                similarMoviesArray.append(contentsOf:similarMovies)
            }else{
                guard let similarMovies = try await manager.fetchSimilarMovies(with: id).results else{
                    return
                }
                similarMoviesArray.append(contentsOf:similarMovies)
            }
        }
    }
    
    
    
}
