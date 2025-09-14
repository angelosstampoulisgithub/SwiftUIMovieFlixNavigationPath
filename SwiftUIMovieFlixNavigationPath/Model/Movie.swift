//
//  Movie.swift
//  MovieFlixSwiftUI
//
//  Created by Angelos Staboulis on 15/9/25.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalResults: Int
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct Movie: Codable, Identifiable,Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let genreIDs: [Int]?    // for search/popular where you get IDs
    let voteAverage: Double?
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genreIDs = "genre_ids"
        case voteAverage = "vote_average"
    }

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}

// For detailed movie including genres and cast
struct MovieDetail: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let genres: [Genre]
    let voteAverage: Double?
    let credits: CreditsResponse?

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case genres
        case voteAverage = "vote_average"
        case credits
    }

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    var backdropURL: URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w780\(path)")
    }
}

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}

struct CreditsResponse: Codable {
    let cast: [CastMember]
    // can also include crew if you want director etc.

    struct CastMember: Codable, Identifiable {
        let id: Int
        let name: String
        let character: String?
        let profilePath: String?

        enum CodingKeys: String, CodingKey {
            case id, name, character
            case profilePath = "profile_path"
        }

        var profileURL: URL? {
            guard let path = profilePath else { return nil }
            return URL(string: "https://image.tmdb.org/t/p/w185\(path)")
        }
    }
}
