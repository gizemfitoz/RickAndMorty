//
//  CharacterDetailWorker.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation
import API

protocol CharacterDetailWorkingLogic: AnyObject {
    func getCharacter(id: Int,
                      onSuccess: @escaping (CharactersResponse.Character) -> Void,
                      onError: @escaping (String) -> Void)
    
    func getEpisode(url: String,
                    onSuccess: @escaping (EpisodeResponse) -> Void,
                    onError: @escaping (String) -> Void)
    
    func saveFavorite(id: Int)
    func removeFavorite(id: Int)
    func isFavorite(id: Int) -> Bool
}

final class CharacterDetailWorker: CharacterDetailWorkingLogic {
    func getCharacter(id: Int,
                      onSuccess: @escaping (CharactersResponse.Character) -> Void,
                      onError: @escaping (String) -> Void) {
        API.getCharacter(id: id, onSuccess: onSuccess, onError: onError)
    }
    
    func getEpisode(url: String,
                    onSuccess: @escaping (EpisodeResponse) -> Void,
                    onError: @escaping (String) -> Void) {
        API.getEpisode(url: url,
                       onSuccess: onSuccess,
                       onError: onError)
    }
    
    func saveFavorite(id: Int) {
        var favorites = getFavorites()
        if !favorites.contains(id) {
            favorites.append(id)
        }
        save(favorites: favorites)
    }
    
    func removeFavorite(id: Int) {
        var favorites = getFavorites()
        if let index = favorites.firstIndex(of: id) {
            favorites.remove(at: index)
        }
        save(favorites: favorites)
    }
    
    func isFavorite(id: Int) -> Bool {
        return getFavorites().contains(id)
    }
    
    private func getFavorites() -> [Int] {
        let defaults = UserDefaults.standard
        return defaults.array(forKey: "favorites") as? [Int] ?? [Int]()
    }
    
    private func save(favorites: [Int]) {
        let defaults = UserDefaults.standard
        defaults.set(favorites, forKey: "favorites")
    }
}
