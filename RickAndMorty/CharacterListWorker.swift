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
                       onSuccess: @escaping (CharactersResponse) -> Void,
                       onError: @escaping (String) -> Void)
}

final class CharacterListWorker: CharacterListWorkingLogic {
    func getCharacters(page: String,
                       onSuccess: @escaping (CharactersResponse) -> Void,
                       onError: @escaping (String) -> Void) {
        API.getCharacters(page: page, onSuccess: onSuccess, onError: onError)
    }
}
