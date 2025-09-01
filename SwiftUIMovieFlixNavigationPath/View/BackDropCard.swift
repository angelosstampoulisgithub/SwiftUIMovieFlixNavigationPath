//
//  BackDropCard.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 26/8/25.
//

import SwiftUI
struct BackDropCard: View {
    
    let movie: Movie
    @State var movieImagePath:String
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                if movieImagePath.count == 0 {
                    Image("themovie").resizable()
                }else{
                    AsyncImage(url: movie.backdropURL) { image in
                        image
                            .resizable()
                    } placeholder: {
                        ProgressView()
                        
                        
                    }.frame(width: 300, height: 295)
                    .listRowSeparator(.hidden)
                }
            }.task {
                movieImagePath = movie.backdropPath ?? ""
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            
            Text(movie.title)
            Text(movie.releaseDate!)
        }
       
        
    }
}

