//
//  MovieListViewModel.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 8/1/25.
//

import Foundation
import SwiftUI
@MainActor
final class MovieListViewModel:ObservableObject {
    
    private var manager = NetworkManager()
    
    @Published  var popularMovies: [MovieListResultsModel] = []
    @Published  var movieDetails:[MovieDetailModel]=[]
    private (set) var favoriteMovies: [Int] = UserDefaults.standard.array(forKey: "Favorites") as? [Int] ?? []
    
    func fetchPopularMovies()  {
        Task{
            let movies = try await manager.fetchMovieList()
            for movie in 0..<movies.results!.count{
                popularMovies.append(movies.results![movie])
            }
        }
    }
    func fethMovieDetails(id:Int) async -> MovieDetailModel {
        return await withCheckedContinuation { continuation in
            Task{
                continuation.resume(returning:try await manager.fetchMovieDetails(with: id))
            }
        }
        
    }
    func feetchSimilarMovies(id:Int) async -> SimilarMoviesModel {
        return await withCheckedContinuation { continuation in
            Task{
                continuation.resume(returning:try await manager.fetchSimilarMovies(with: id))
            }
        }
        
    }
    func addToFavorites(with id: Int) {
        favoriteMovies.append(id)
        UserDefaults.standard.set(favoriteMovies, forKey: "Favorites")
    }
    
    func removeFromFavorites(with id: Int) {
        favoriteMovies.removeAll(where: {$0 == id})
        UserDefaults.standard.set(favoriteMovies, forKey: "Favorites")
    }
    

   
}
