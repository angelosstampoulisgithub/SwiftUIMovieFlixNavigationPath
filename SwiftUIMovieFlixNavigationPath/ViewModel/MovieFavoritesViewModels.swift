//
//  MovieFavoritesViewModels.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 2/8/25.
//

import Foundation
@MainActor
class MovieFavoritesViewModels{
    private (set) var favoriteMovies: [Int] = UserDefaults.standard.array(forKey: "Favorites") as? [Int] ?? []
    func addToFavorites(with id: Int) {
        favoriteMovies.append(id)
        UserDefaults.standard.set(favoriteMovies, forKey: "Favorites")
    }
    
    func removeFromFavorites(with id: Int) {
        favoriteMovies.removeAll(where: {$0 == id})
        UserDefaults.standard.set(favoriteMovies, forKey: "Favorites")
    }
    
}
