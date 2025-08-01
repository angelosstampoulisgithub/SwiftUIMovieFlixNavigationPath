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
    private (set) var favoriteMovies: [Int] = UserDefaults.standard.array(forKey: "Favorites") as? [Int] ?? []
   
    func fetchSearchResults(for query: String) {
        searchResults = popularMovies.filter { product in
            product.title!
                .contains(query)
        }
    }
    func movieSimilarArray(id:Int) async{
        Task{
            do{
                let similarMovies = try await fetchSimilarMovies(id: id)
                guard let results = similarMovies.results else{
                    return
                }
                for item in 0..<results.count{
                    similarMoviesArray.append(results[item])
                }
            }catch{
                print("something went wrong!!!!")
            }
        }
    }
    func fetchPopularMovies(isLoading:Bool) {
        if isLoading {
            Task{
                guard let movies = try await manager.fetchMovieList().results else{
                    return
                }
                for movie in 0..<movies.count{
                    popularMovies.append(movies[movie])
                }
            }
        }else{
            popularMovies.removeAll()
            similarMoviesArray.removeAll()
            Task{
                guard let movies = try await manager.fetchMovieList().results else{
                    return
                }
                for movie in 0..<movies.count{
                    popularMovies.append(movies[movie])
                }
            }
        }
        
    }
    func fethMovieDetails(id:Int) async throws -> MovieDetailModel {
        return try await manager.fetchMovieDetails(with: id)
    }
    func fetchSimilarMovies(id:Int) async throws -> SimilarMoviesModel {
        return try await manager.fetchSimilarMovies(with: id)
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
