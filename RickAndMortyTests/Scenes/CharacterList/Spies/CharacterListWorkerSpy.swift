//
//  CharacterListWorkerSpy.swift
//  RickAndMortyTests
//
//  Created by Gizem Fitoz on 4.04.2021.
//

import Foundation
@testable import RickAndMorty
@testable import API

class CharacterListWorkerSpy: CharacterListWorkingLogic {
    func isFavorite(id: Int) -> Bool {
        // TODO
        return true
    }
    
    var testErrorCase = false
    
    func getCharacters(page: String, name: String, status: String, onSuccess: @escaping (CharactersResponse) -> Void, onError: @escaping (String) -> Void) {
        StubHelper.getModel(from: testErrorCase ? "Error" : "Characters", onSuccess: onSuccess, onError: onError)
    }    
}
