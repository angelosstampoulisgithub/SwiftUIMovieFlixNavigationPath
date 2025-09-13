//
//  ContentView.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 8/1/25.
//

import SwiftUI
struct ContentView: View {
    @State var movieTitle:String
    @State var isSearching: Bool
    
    @StateObject var popularState:MovieDetailState
    @StateObject var navigationManager = NavigationManager()
    @State var searchQuery: String = ""
    @State var searchResults:[Movie]
    @State var movieID:Int
    @FocusState private var isFocused: Bool
    var body: some View {
        NavigationStack(path:$navigationManager.path) {
            VStack{
                ZStack{
                    VStack{
                        TextField("Enter Movie Title and then press Enter", text: $movieTitle)
                            .focused($isFocused)
                            .frame(width: 300,height:45,alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .onChange(of: movieTitle, { oldValue, newValue in
                                isFocused = true
                                isSearching = true
                                self.searchResults.removeAll()
                                self.popularState.searchMovie(query: movieTitle)

                            }).onSubmit {
                                guard let response = popularState.response else{
                                    return
                                }
                                response.results.forEach { movie in
                                    searchResults.append(movie)
                                }
                            }
                    }.frame(maxWidth: .infinity,maxHeight: 50,alignment: .top)
                        .padding(20)
                }
                List(isSearching ? self.searchResults : self.popularState.movies ?? []){movie in
                        HStack{
                            BackDropCard(movie: movie, movieImagePath: "").listRowSeparator(.hidden)
                            Image(systemName: "arrow.right").onTapGesture {
                                navigationManager.push(route: AppRoute.details)
                                movieID = movie.id
                        }
                    }.listRowSeparator(.hidden)
                   
                       
                }.navigationDestination(for: AppRoute.self) { route in
                    if route == .details{
                        MovieDetailView(movieId: movieID)
                    }
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


