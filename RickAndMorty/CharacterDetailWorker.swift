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
}
