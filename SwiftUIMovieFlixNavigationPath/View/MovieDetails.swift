//
//  MovieDetails.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 9/1/25.
//

import SwiftUI

struct MovieDetails: View {
    @State var  movie:MovieListResultsModel
    @State var details:MovieDetailModel
    @State var similarMovies:SimilarMoviesModel
    @State var detailsMovieArray:[MovieDetailModel] = []
    @EnvironmentObject var viewModel:MovieListViewModel
    @State var isHeart:Bool
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: details.getImageUrl()))
                VStack{
                    VStack{
                        Text(details.title!).padding(5)
                        Text(details.release_date!)
                        HStack{
                            Image("rating").padding(5)
                            Text(String(describing:details.vote_average!))
                        }
                    }
                }.frame(width:200,height:145)
                HStack{
                    Button {
                        isHeart.toggle()
                    } label: {
                        Image(systemName: isHeart ?  "heart.fill" : "heart" ).padding(5)
                    }
                }
                Text("Overview").frame(width:300,height:45,alignment: .leading)
                Text((details.overview!)).frame(width:300,height:250,alignment: .leading)
                Text("Similar Movies").frame(width:300,height:45,alignment: .leading)
                ScrollView(.horizontal){
                    HStack{
                        ForEach(detailsMovieArray,id:\.self){movie in
                            AsyncImage(url: URL(string: movie.getImageUrl())) { image in
                                image.resizable()
                                    .frame(width:150,height:145)
                                    .aspectRatio(contentMode: .fit) 
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }.frame(width:300)
            }
        }.task{
            do{
                details = try await viewModel.fethMovieDetails(id: movie.id!)
                similarMovies = try await viewModel.feetchSimilarMovies(id: movie.id!)
                for item in 0..<similarMovies.results!.count{
                    detailsMovieArray.append(similarMovies.results![item])
                }
            }catch{
                print("something went wrong!!!!")
            }
            if let favorites = UserDefaults.standard.array(forKey: "Favorites") as? [Int] {
                if favorites.contains(movie.id!) {
                    movie.isFavorite = true
                    isHeart = movie.isFavorite
                }else{
                    movie.isFavorite = false
                    isHeart = movie.isFavorite
                }
            }
           
            
            
        }.navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

