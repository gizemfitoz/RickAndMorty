//
//  CharacterListRouterSpy.swift
//  RickAndMortyTests
//
//  Created by Gizem Fitoz on 4.04.2021.
//

import Foundation
@testable import RickAndMorty

class CharacterListRouterSpy: CharacterListRoutingLogic, CharacterListDataPassing {
    var dataStore: CharacterListDataStore?
    
    var routeToCharacterDetailCalled = false
    func routeToCharacterDetail() {
        routeToCharacterDetailCalled = true
    }
}
