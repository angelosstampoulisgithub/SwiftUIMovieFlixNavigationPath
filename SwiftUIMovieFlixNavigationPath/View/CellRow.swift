//
//  CellRow.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 9/1/25.
//

import SwiftUI
struct CellRow: View {
    @State var movie:MovieListResultsModel
    @EnvironmentObject var viewModel:MovieListViewModel
    @State var isHeart:Bool
    var body: some View {
            HStack{
                AsyncImage(url: URL(string: movie.getImageUrl())) { image in
                    image
                        .resizable()
                        .frame(width:155,height:150,alignment: .leading)
                } placeholder: {
                    ProgressView()
                }
                VStack{
                    VStack{
                        Text(movie.title!).padding(5)
                        Text(movie.release_date!)
                        HStack{
                            Image("rating").padding(5)
                            Text(String(format:"%.2f",movie.vote_average!))
                        }
                    }
                    HStack{
                        Button {
                            isHeart.toggle()
                            viewModel.addToFavorites(with: movie.id!)
                        } label: {
                            Image(systemName: isHeart ?  "heart.fill" : "heart" ).padding(5)
                        }
                    }
                }.frame(width:200,height:195)
               
               

                

            }.onAppear {
                if let favorites = UserDefaults.standard.array(forKey: "Favorites") as? [Int] {
                    if favorites.contains(movie.id!) {
                        movie.isFavorite = true
                        isHeart = movie.isFavorite
                    }else{
                        movie.isFavorite = false
                        isHeart = movie.isFavorite
                    }
                }
            }
        }
}

