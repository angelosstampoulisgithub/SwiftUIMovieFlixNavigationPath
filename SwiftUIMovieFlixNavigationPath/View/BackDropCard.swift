//
//  BackDropCard.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 26/8/25.
//

import SwiftUI

struct BackDropCard: View {
    
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                AsyncImage(url: movie.backdropURL) { image in
                                   image
                                       .resizable()
                } placeholder: {
                                   ProgressView()
                }.frame(width: 300, height: 295)
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            
            Text(movie.title)
            Text(movie.releaseDate!)
        }
       
        
    }
}

