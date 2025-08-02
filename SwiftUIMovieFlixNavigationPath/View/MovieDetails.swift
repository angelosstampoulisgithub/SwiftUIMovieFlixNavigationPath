//
//  MovieDetails.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 9/1/25.
//

import SwiftUI

struct MovieDetails: View {
    @State var  movie:MovieListResultsModel
    @State private var details:MovieDetailModel = .init(id: 0, backdrop_path: "", poster_path: "", genres:[], title: "", overview: "", release_date: "", runtime: 0, vote_average: 0.0, homepage: "")
    @EnvironmentObject var viewModel:MovieListViewModel
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: details.getImageUrl()))
                VStack{
                    VStack{
                        Text(details.title!).padding(5)
                        Text(details.release_date!)
                        HStack{
                            Text(String(describing:details.vote_average!))
                        }
                    }
                }.frame(width:200,height:145)
               
                Text("Overview").frame(width:300,height:45,alignment: .leading)
                Text((details.overview!)).frame(width:300,height:250,alignment: .leading)
                Text("Similar Movies").frame(width:300,height:45,alignment: .leading)
                ScrollView(.horizontal){
                    HStack{
                        ForEach(viewModel.similarMoviesArray,id:\.self){movie in
                            if movie.getImageUrl().contains("photo"){
                               EmptyView()
                            }else{
                                AsyncImage(url: URL(string: movie.getImageUrl())) { image in
                                    image.resizable()
                                        .frame(width:150,height:145)
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                    }
                }.frame(width:300)
            }.task{
                do{
                    try await viewModel.fetchSimilarMovies(id: movie.id!)
                }catch{
                    print("something went wrong!!!!")
                }
            }
        }.task{
            do{
                details = try await viewModel.fethMovieDetails(id: movie.id!)
                

            }catch{
                print("something went wrong!!!!")
            }
        }.navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

