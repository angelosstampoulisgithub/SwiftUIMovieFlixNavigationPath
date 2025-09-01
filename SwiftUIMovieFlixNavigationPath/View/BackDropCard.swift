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
                        if movie.backdropPath == nil{
                            Text("Content unavailable")
                        }else{
                            Text("Loading")
                        }
                        
                        
                    }.frame(width: 300, height: 295)
                    .listRowSeparator(.hidden)
                
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            
            Text(movie.title)
            Text(movie.releaseDate!)
        }
       
        
    }
}

