//
//  CharacterDetailModels.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation
import API

enum CharacterDetail {
    enum Character {
        struct Request {}
        
        struct Response {
            var character: CharactersResponse.Character
            var isFavorite: Bool
        }
        
        struct ViewModel {
            var isFavorite: Bool
            var image: String
            var name: String
            var status: String
            var species: String
            var gender: String
            var numberOfEpisodes: String
            var originLocationName: String
            var lastKnownLocationName: String
        }
    }
    
    enum Episode {
        struct Response {
            var episode: EpisodeResponse
        }
        
        struct ViewModel {
            var lastSeenEpisodeName: String
            var lastSeenEpisodeAirDate: String
        }
    }
    
    enum Favorite {        
        struct Response {
            var isFavorite: Bool
        }
        
        struct ViewModel {
            var isFavorite: Bool
        }
    }
}
