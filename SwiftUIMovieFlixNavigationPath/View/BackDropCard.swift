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
                AsyncImage(url: movie.backdropURL) { image in
                                   image
                                       .resizable()
                } placeholder: {
                    if movieImagePath.count == 0 {
                        Image("imdb").resizable()
                    }else{
                        ProgressView()
                    }
                    
                }.frame(width: 300, height: 295)
            }.onAppear(perform: {
                movieImagePath = movie.backdropPath ?? ""
            })
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            
            Text(movie.title)
            Text(movie.releaseDate!)
        }
       
        
    }
}

