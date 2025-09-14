//
//  NetworkService.swift
//  MovieFlixSwiftUI
//
//  Created by Angelos Staboulis on 15/9/25.
//

import Foundation
enum MovieServiceError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}

class NetworkService {
    private let apiKey: String
    private let baseURL = "https://api.themoviedb.org/3/movie"

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func fetchPopularMovies() async throws -> [Movie] {
        // Construct URL
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=d8d8c423")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZjIyYzdiMDBjNTdlYTk2N2ZhMTg5ZGFmZDk2MzA3NiIsInN1YiI6IjY0NTM5NDY4ZDQ4Y2VlMDBmY2VkZTY5YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S-sRwU7SB8gnT_3RYSC-6Hm48jEP3Hd6eHiHKTz13nA", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw MovieServiceError.requestFailed
        }

        // Decode
        do {
            let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
            return decoded.results
        } catch {
            throw MovieServiceError.decodingFailed
        }
    }
    func searcbMovies(query:String) async throws -> [Movie] {
        // Construct URL
        
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/search/movie?query=\(query)&api_key=d8d8c423")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZjIyYzdiMDBjNTdlYTk2N2ZhMTg5ZGFmZDk2MzA3NiIsInN1YiI6IjY0NTM5NDY4ZDQ4Y2VlMDBmY2VkZTY5YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S-sRwU7SB8gnT_3RYSC-6Hm48jEP3Hd6eHiHKTz13nA", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw MovieServiceError.requestFailed
        }

        // Decode
        do {
            let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
            return decoded.results
           
        } catch {
            throw MovieServiceError.decodingFailed
        }
    }
    func fetchMovieDetail(id:Int) async throws -> MovieDetail{
        // Construct URL
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=d8d8c423&append_to_response=credits")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZjIyYzdiMDBjNTdlYTk2N2ZhMTg5ZGFmZDk2MzA3NiIsInN1YiI6IjY0NTM5NDY4ZDQ4Y2VlMDBmY2VkZTY5YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S-sRwU7SB8gnT_3RYSC-6Hm48jEP3Hd6eHiHKTz13nA", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw MovieServiceError.requestFailed
        }

        // Decode
        do {
            let decoded = try JSONDecoder().decode(MovieDetail.self, from: data)
            return decoded
        } catch {
            throw MovieServiceError.decodingFailed
        }
    }
}
