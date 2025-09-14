//
//  MovieRowview.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 15/9/25.
//

import SwiftUI

struct MovieRowview: View {
    let movie: Movie

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            if let url = movie.posterURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 100, height: 150)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 150)
                            .clipped()
                            .cornerRadius(8)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 150)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                    .foregroundColor(.gray)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.headline)
                if let date = movie.releaseDate {
                    Text("Release: \(date)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                if let vote = movie.voteAverage {
                    Text(String(format: "Rating: %.1f", vote))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Text(movie.overview)
                    .font(.body)
                    .lineLimit(3)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

