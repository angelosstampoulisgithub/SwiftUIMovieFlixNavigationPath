//
//  ContentView.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 8/1/25.
//

import SwiftUI
struct ContentView: View {
    @State var movieTitle:String
    var isSearching: Bool {
        return !movieTitle.isEmpty
    }
    @StateObject var popularState:MovieDetailState
    @State var searchQuery: String = ""
    @State var searchResults:[Movie]
    var body: some View {
        NavigationView {
            VStack{
                ZStack{
                    VStack{
                        TextField("Movie Title", text: $movieTitle)
                            .frame(width: 300,height:45,alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .onChange(of: movieTitle, { oldValue, newValue in
                                    self.popularState.searchMovie(query: movieTitle)
                            }).onSubmit {
                                if searchResults.count > 0 {
                                    searchResults.removeAll()
                                    guard let response = popularState.response else{
                                        return
                                    }
                                    searchResults.append(contentsOf: response.results.compactMap{$0})
                                }else{
                                    guard let response = popularState.response else{
                                        return
                                    }
                                    searchResults.append(contentsOf: response.results.compactMap{$0})
                                }

                            }
                    }.frame(maxWidth: .infinity,maxHeight: 50,alignment: .top)
                        .padding(20)
                }
                List(isSearching ? self.searchResults : self.popularState.movies ?? []){movie in
                        
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            BackDropCard(movie: movie).listRowSeparator(.hidden)
                        }.listRowSeparator(.hidden)
                }
                    .scrollContentBackground(.hidden)
                    .navigationBarTitle("The MovieDb")
                    .navigationBarTitleDisplayMode(.inline)
                
            }
        }.task {
            self.popularState.loadMovies(with: .popular)
        }
        
    }
    
}


