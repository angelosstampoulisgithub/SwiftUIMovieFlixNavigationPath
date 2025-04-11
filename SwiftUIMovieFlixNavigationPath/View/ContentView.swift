//
//  ContentView.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 8/1/25.
//

import SwiftUI
struct ContentView: View {
    @EnvironmentObject var viewModel:MovieListViewModel
    @StateObject var navigationManager = NavigationManager()
    @State var movieTitle:String
    @State var searchResults:[MovieListResultsModel] = []
    var isSearching: Bool {
        return !movieTitle.isEmpty
    }
    @State var isHeart:Bool
    @State var isShowingDetailView:Int = 0
    @State private var isLoading = true
    @State var getSelected:MovieListResultsModel

    var body: some View {
        NavigationStack(path:$navigationManager.path){
            ScrollView{
                ForEach(isSearching ? searchResults.unique() : viewModel.popularMovies,id:\.self){item in
                    VStack{
                        HStack{
                            CellRow(movie: item, isHeart: false).redacted(reason: isLoading ? .placeholder : [])
                            
                            Button {
                                getSelected = item
                                navigationManager.push(AppRoute.detailsView)
                            } label: {
                                HStack{
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 7)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }.task{
                    viewModel.fetchPopularMovies()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    isLoading = false
                    }
                }.searchable(text: $movieTitle)
                
                .onChange(of: movieTitle) { oldValue, newValue in
                        fetchSearchResults(for: newValue)
                }
            }.navigationTitle("SwiftUIMovieFlix")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: AppRoute.self) { item in
                if item == .detailsView{
                    MovieDetails(movie: getSelected, details: .init(id: 0, backdrop_path: "", poster_path: "", genres: [], title: "", overview: "", release_date: "", runtime: 0, vote_average: 0.0, homepage: ""), similarMovies: .init(results: []), isHeart: false)
                }
            }
        }
    }
    func fetchSearchResults(for query: String) {
        searchResults = viewModel.popularMovies.filter { product in
            product.title!
                .contains(movieTitle)
        }
    }
}

