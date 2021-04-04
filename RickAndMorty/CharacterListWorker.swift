//
//  CharacterListWorker.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation
import API

protocol CharacterListWorkingLogic: AnyObject {
    func getCharacters(page: String,
                       name: String,
                       status: String,
                       onSuccess: @escaping (CharactersResponse) -> Void,
                       onError: @escaping (String) -> Void)
    func isFavorite(id: Int) -> Bool
}

final class CharacterListWorker: CharacterListWorkingLogic {
    func getCharacters(page: String,
                       name: String,
                       status: String,
                       onSuccess: @escaping (CharactersResponse) -> Void,
                       onError: @escaping (String) -> Void) {
        API.getCharacters(page: page,
                          name: name,
                          status: status,
                          onSuccess: onSuccess,
                          onError: onError)
    }
    
    func isFavorite(id: Int) -> Bool {
        let defaults = UserDefaults.standard
        let favorites = defaults.array(forKey: "favorites") as? [Int] ?? [Int]()
        return favorites.contains(id)
    }
}
