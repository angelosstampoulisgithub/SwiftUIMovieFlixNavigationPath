//
//  NetworkManager.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 4/2/25.
//

import Foundation
let imagePath = "https://image.tmdb.org/t/p/w500"

final class NetworkManager {
    let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZjIyYzdiMDBjNTdlYTk2N2ZhMTg5ZGFmZDk2MzA3NiIsInN1YiI6IjY0NTM5NDY4ZDQ4Y2VlMDBmY2VkZTY5YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S-sRwU7SB8gnT_3RYSC-6Hm48jEP3Hd6eHiHKTz13nA"    
    func fetchMovieList() async throws -> MovieListModel {
        let requestUrl = "https://api.themoviedb.org/3/movie/popular"
        var request = URLRequest(url:URL(string:requestUrl)!)
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(MovieListModel.self, from: data)
    }
    
    func searchDataBase(with keyword: String) async throws -> MovieListModel {
        let requestUrl = "https://api.themoviedb.org/3/search/movie?query=\(keyword)"
        var request = URLRequest(url:URL(string:requestUrl)!)
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(MovieListModel.self, from: data)
    }
    
    func fetchMovieDetails(with id: Int) async throws -> MovieDetailModel {
        let requestUrl = "https://api.themoviedb.org/3/movie/\(id)"
        var request = URLRequest(url:URL(string:requestUrl)!)
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(MovieDetailModel.self, from: data)
    }
    
    func fetchMovieReviews(with id: Int) async throws -> MovieReviewsModel {
        let requestUrl = "https://api.themoviedb.org/3/movie/\(id)/reviews"
        var request = URLRequest(url:URL(string:requestUrl)!)
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(MovieReviewsModel.self, from: data)
    }
    
    func fetchSimilarMovies(with id: Int) async throws -> SimilarMoviesModel {
        let requestUrl = "https://api.themoviedb.org/3/movie/\(id)/similar"
        var request = URLRequest(url:URL(string:requestUrl)!)
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(SimilarMoviesModel.self, from: data)
    }
}
