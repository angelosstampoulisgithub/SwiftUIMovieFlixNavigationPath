//
//  MovieModel.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 4/2/25.
//

import Foundation
//MARK: Detail
struct MovieDetailModel: Decodable,Hashable,Equatable {
    let id: Int?
    let backdrop_path: String?
    let poster_path: String?
    let genres: [GenreModel]?
    var isFavorite:Bool?
    let title: String?
    let overview: String?
    let release_date: String?
    let runtime: Int?
    let vote_average: Double?
    let homepage: String?
    public func getImageUrl() -> String {
           if backdrop_path == nil{
               return "photo"
           }else{
               return "https://image.tmdb.org/t/p/w500" + backdrop_path!
           }
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}

struct GenreModel: Decodable,Equatable {
    let name: String?
    let id: Int?
}

//MARK: Review
struct MovieReviewsModel: Decodable {
    let id: Int?
    let results: [ReviewModel]?
}

struct ReviewModel: Decodable {
    let author: String?
    let content: String?
}

//MARK: Similar
struct SimilarMoviesModel: Decodable,Equatable {
    let results: [MovieDetailModel]?
    let id: Int?

}
