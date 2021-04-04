//
//  CharacterDetailWorkerSpy.swift
//  RickAndMortyTests
//
//  Created by Gizem Fitoz on 4.04.2021.
//

import Foundation
@testable import RickAndMorty
@testable import API

class CharacterDetailWorkerSpy: CharacterDetailWorkingLogic {
    var testErrorCase = false

    func getCharacter(id: Int, onSuccess: @escaping (CharactersResponse.Character) -> Void, onError: @escaping (String) -> Void) {
        StubHelper.getModel(from: testErrorCase ? "Error" : "Character", onSuccess: onSuccess, onError: onError)
    }
    
    func getEpisode(url: String, onSuccess: @escaping (EpisodeResponse) -> Void, onError: @escaping (String) -> Void) {
        StubHelper.getModel(from: testErrorCase ? "Error" : "Episode", onSuccess: onSuccess, onError: onError)
    }
    
    func saveFavorite(id: Int) {
        CharacterDetailWorker().saveFavorite(id: id)
    }
    
    func removeFavorite(id: Int) {
        CharacterDetailWorker().removeFavorite(id: id)
    }
    
    func isFavorite(id: Int) -> Bool {
        return CharacterDetailWorker().isFavorite(id: id)
    }
}
