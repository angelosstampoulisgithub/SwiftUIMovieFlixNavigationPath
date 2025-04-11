//
//  MovieListModel.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 4/2/25.
//

import Foundation
struct MovieListModel: Decodable{
    let page: Int?
    let results: [MovieListResultsModel]?
    let total_pages: Int?
    let total_results: Int?
}

struct MovieListResultsModel: Decodable,Hashable {
    let backdrop_path: String?
    let id: Int?
    let release_date: String?
    let title: String?
    let vote_average: Double?
    let vote_count: Int?
    var isFavorite:Bool! = false
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    public func getImageUrl() -> String {
           if backdrop_path == nil{
               return "photo"
           }else{
               return "https://image.tmdb.org/t/p/w500" + backdrop_path!
           }
    }
}
