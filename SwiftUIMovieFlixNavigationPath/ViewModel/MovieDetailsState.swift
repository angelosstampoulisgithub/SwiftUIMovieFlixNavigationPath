//
//  MovieDetailsState.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 26/8/25.
//

import Foundation
class MovieDetailState: ObservableObject {
    
    private let movieService: MovieService
    @Published var movie: Movie?
    @Published var response:MovieResponse?
    @Published var isLoading = false
    @Published var error: NSError?
    @Published var movies: [Movie]?

    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadMovie(id: Int) {
        self.movie = nil
        self.isLoading = false
        self.movieService.fetchMovie(id: id) {[weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    func searchMovie(query: String) {
        self.movie = nil
        self.isLoading = false
        self.movieService.searchMovie(query: query) {[weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let response):
                self.response = response
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    func loadMovies(with endpoint: MovieListEndpoint) {
        self.movies = nil
        self.isLoading = true
        self.movieService.fetchMovies(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
