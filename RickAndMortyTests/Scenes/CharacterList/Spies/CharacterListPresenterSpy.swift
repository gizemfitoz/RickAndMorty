//
//  CharacterListPresenterSpy.swift
//  RickAndMortyTests
//
//  Created by Gizem Fitoz on 4.04.2021.
//

import Foundation
@testable import RickAndMorty

class CharacterListPresenterSpy: CharacterListPresentationLogic {
    var presentPagedCharactersCalled = false
    func presentPagedCharacters(response: CharacterList.Characters.Response) {
        presentPagedCharactersCalled = true
    }
    
    var presentLayoutTypeCalled = false
    func presentLayoutType(response: CharacterList.ToggleLayoutType.Response) {
        presentLayoutTypeCalled = true
    }
    
    var presentCharacterDetailCalled = false
    func presentCharacterDetail() {
        presentCharacterDetailCalled = true
    }
    
    var presentLastSelectedItemCalled = false
    func presentLastSelectedItem(response: CharacterList.LastSelectedCharacter.Response) {
        presentLastSelectedItemCalled = true
    }
    
    var clearCharactersCalled = false
    func clearCharacters() {
        clearCharactersCalled = true
    }
    
    var presentLoaderCalled = false
    func presentLoader(hide: Bool) {
        presentLoaderCalled = true
    }
    
    var presentErrorCalled = false
    func presentError(error: String) {
        presentErrorCalled = true
    }
}
