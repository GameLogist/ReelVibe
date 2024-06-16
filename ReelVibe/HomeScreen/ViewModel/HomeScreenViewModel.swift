//
//  HomeScreenViewModel.swift
//  ReelVibe
//
//  Created by Ayush Tiwari on 11/06/24.
//

import Foundation
import SwiftUI

enum eHomeScreenCardType: String, CaseIterable {
    case trending = "Trending"
    case nowPlaying = "Now Playing"
    case upcoming = "Upcoming Movies"
    case popular = "Popular Movies"
    case topRated = "Top Rated"
}

struct Filter {
    var cardType: eHomeScreenCardType
    var playlist: Playlist
}

@MainActor
class HomeScreenViewModel: ObservableObject {
    // Single truth: All the API data will be stored here and will NOT be altered
    @Published var trendingAllDayMovies: [Movie] = []
    @Published var trendingAllWeekMovies: [Movie] = []
    @Published var nowPlayingMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    
    // This is what the app actually shows based on filters for each section
    @Published var filteredTrendingAllDayMovies: [Movie] = []
    @Published var filteredTrendingAllWeekMovies: [Movie] = []
    @Published var filteredNowPlayingMovies: [Movie] = []
    @Published var filteredUpcomingMovies: [Movie] = []
    @Published var filteredPopularMovies: [Movie] = []
    @Published var filteredTopRatedMovies: [Movie] = []
    
    @Published var currentlyTappedSection: eHomeScreenCardType?
    @Published var currentPlaylistFilter: [Filter] = []
    
    @Published var loading: Bool = false
    @Published var showBottomPlaylistFilterSheet: Bool = false
    
    // True = Day, False = Week
    @Published var trendingMovieToggle: Bool = false
    
    var homeScreenDataSource: [eHomeScreenCardType] = [
        .trending,
        .nowPlaying,
        .upcoming,
        .popular,
        .topRated
    ]
    
    init() {
        getTrendingAllDayMovies()
        getTrendingAllWeekMovies()
        getNowPlayingMovies()
        getUpcomingMovies()
        getPopularMovies()
        getTopRatedMovies()
    }
    
    func addPlaylistToFilterBy(playlist: Playlist) {
        print("Adding \(playlist.title) to filters!")
        guard let type = currentlyTappedSection else { return }
        currentPlaylistFilter.append(Filter(cardType: type, playlist: playlist))
        
        // Apply this filter to curently shown list
        applyFiltersToASection()
    }
    
    func removePlaylistToFilterBy(playlist: Playlist) {
        guard currentlyTappedSection != nil else { return }
        if let index = currentPlaylistFilter.firstIndex(where: {$0.playlist.id == playlist.id}) {
            print("Removing \(playlist.title) from filters!")
            currentPlaylistFilter.remove(at: index)
        }
        
        // Apply this filter to curently shown list
        applyFiltersToASection()
    }
    
    func updateMovieToPlaylistFilter(playlist: Playlist) {
        for filterPlaylist in currentPlaylistFilter {
            if(filterPlaylist.playlist.id == playlist.id) {
                filterPlaylist.playlist.movies = playlist.movies
                print("Movies updates in filter")
            }
        }
        updateAllSectionsWithFilters()
    }
    
    func updateAllSectionsWithFilters() {
        for iter in eHomeScreenCardType.allCases {
            currentlyTappedSection = iter
            print("Updating section with \(iter)")
            applyFiltersToASection()
        }
    }
    
    func applyFiltersToASection() {
        // If no section is selected then return
        guard let section = currentlyTappedSection else { return }
        
        // Get all the filters for the currentSection
        let currentSectionFilters: [Filter] = currentPlaylistFilter.filter({$0.cardType == section})
        if(currentSectionFilters.isEmpty) {
            // There are no filters for the current section
            // based on the current section type, re instate the source truth in that filter object
            switch section {
            case .trending:
                filteredTrendingAllDayMovies = trendingAllDayMovies
            case .nowPlaying:
                filteredNowPlayingMovies = nowPlayingMovies
            case .upcoming:
                filteredUpcomingMovies = upcomingMovies
            case .popular:
                filteredPopularMovies = popularMovies
            case .topRated:
                filteredTopRatedMovies = topRatedMovies
            }
        } else {
            // Get All Movies from all playlists in one array
            var allMoviesInFilteredPlaylistsForThisSection: [Movie] = []
            for filter in currentSectionFilters {
                allMoviesInFilteredPlaylistsForThisSection.append(contentsOf: filter.playlist.movies)
            }
            
            // Now find intersection of the movies from the current section and the above array
            let allMoviesInThisSection: [Movie] = getMovieData(cardType: section)
            let commonArray = allMoviesInThisSection.filter { movie in
                allMoviesInFilteredPlaylistsForThisSection.contains(movie)
            }
            switch section {
            case .trending:
                filteredTrendingAllDayMovies = commonArray
            case .nowPlaying:
                filteredNowPlayingMovies = commonArray
            case .upcoming:
                filteredUpcomingMovies = commonArray
            case .popular:
                filteredPopularMovies = commonArray
            case .topRated:
                filteredTopRatedMovies = commonArray
            }
        }
    }
    
    func getMovieData(cardType: eHomeScreenCardType) -> [Movie] {
        switch cardType {
        case .trending:
            trendingAllDayMovies
        case .nowPlaying:
            nowPlayingMovies
        case .upcoming:
            upcomingMovies
        case .popular:
            popularMovies
        case .topRated:
            topRatedMovies
        }
    }
    
    func searchInPlaylistFilters(playlist: Playlist) -> Bool {
        return (currentPlaylistFilter.filter{$0.playlist.id == playlist.id && $0.cardType == currentlyTappedSection}.count > 0)
    }
    
    ///
    /// DATA FETCHING
    ///
    
    func getTrendingAllDayMovies() {
        MoviesServices.getTrendingAllDayMovies(completion: { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("Trending all day movies - \(response?.results?.count ?? 0)")
                    self.trendingAllDayMovies = response?.results ?? []
                    self.filteredTrendingAllDayMovies = response?.results ?? []
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func getTrendingAllWeekMovies() {
        MoviesServices.getTrendingAllWeekMovies(completion: { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("Trending all week movies - \(response?.results?.count ?? 0)")
                    self.trendingAllWeekMovies = response?.results ?? []
                    self.filteredTrendingAllWeekMovies = response?.results ?? []
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func getNowPlayingMovies() {
        MoviesServices.getNowPlayingMovies(completion: { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("Now Playing movies - \(response?.results?.count ?? 0)")
                    self.nowPlayingMovies = response?.results ?? []
                    self.filteredNowPlayingMovies = response?.results ?? []
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func getUpcomingMovies() {
        MoviesServices.getUpcomingMovies(completion: { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("Upcoming movies - \(response?.results?.count ?? 0)")
                    self.upcomingMovies = response?.results ?? []
                    self.filteredUpcomingMovies = response?.results ?? []
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func getPopularMovies() {
        MoviesServices.getPopularMovies(completion: { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("Popular movies - \(response?.results?.count ?? 0)")
                    self.popularMovies = response?.results ?? []
                    self.filteredPopularMovies = response?.results ?? []
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func getTopRatedMovies() {
        loading = true
        MoviesServices.getTopRatedMovies(completion: { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("TopRated movies - \(response?.results?.count ?? 0)")
                    self.topRatedMovies = response?.results ?? []
                    self.filteredTopRatedMovies = response?.results ?? []
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        loading = false
    }
}
