//
//  MovieDetailView.swift
//  MovieFlixSwiftUI
//
//  Created by Angelos Staboulis on 15/9/25.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var viewModel: MovieDetailViewModel
    
    init(movieId: Int, service: NetworkService) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieId: movieId, service: service))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let detail = viewModel.detail {
                    // Backdrop
                    if let backdropURL = detail.backdropURL {
                        AsyncImage(url: backdropURL) { phase in
                            switch phase {
                            case .empty:
                                Color.gray.frame(height: 200)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 200)
                                    .clipped()
                            case .failure:
                                Color.gray.frame(height: 200)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    
                    // Poster + title etc.
                    HStack(alignment: .top, spacing: 16) {
                        if let posterURL = detail.posterURL {
                            AsyncImage(url: posterURL) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 120, height: 180)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 180)
                                        .clipped()
                                        .cornerRadius(8)
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120, height: 180)
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(detail.title)
                                .font(.title)
                                .bold()
                            if let date = detail.releaseDate {
                                Text("Release date: \(date)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            if let vote = detail.voteAverage {
                                Text(String(format: "Rating: %.1f / 10", vote))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            // Genres
                            if !detail.genres.isEmpty {
                                Text("Genres: " + detail.genres.map { $0.name }.joined(separator: ", "))
                                    .font(.subheadline)
                            }
                        }
                    }
                    
                    // Overview
                    Text("Overview")
                        .font(.headline)
                    Text(detail.overview)
                        .font(.body)
                    
                    // Cast / Actors
                    if let cast = detail.credits?.cast, !cast.isEmpty {
                        Text("Cast")
                            .font(.headline)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(cast.prefix(10)) { member in
                                    VStack {
                                        if let profileURL = member.profileURL {
                                            AsyncImage(url: profileURL) { phase in
                                                switch phase {
                                                case .empty:
                                                    Color.gray.frame(width: 80, height: 120)
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 80, height: 120)
                                                        .clipped()
                                                        .cornerRadius(8)
                                                case .failure:
                                                    Image(systemName: "person.crop.square")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 80, height: 120)
                                                        .foregroundColor(.gray)
                                                @unknown default:
                                                    EmptyView()
                                                }
                                            }
                                        } else {
                                            Image(systemName: "person.crop.square")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 80, height: 120)
                                                .foregroundColor(.gray)
                                        }
                                        Text(member.name)
                                            .font(.caption)
                                            .frame(width: 80)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                            .padding(.vertical)
                        }
                    }
                    
                } else if viewModel.isLoading {
                    ProgressView("Loading…")
                        .frame(maxWidth: .infinity, alignment: .center)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadDetail()
        }
    }
}
   
