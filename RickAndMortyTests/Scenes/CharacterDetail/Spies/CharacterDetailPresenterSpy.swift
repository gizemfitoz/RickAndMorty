//
//  CharacterDetailPresenterSpy.swift
//  RickAndMortyTests
//
//  Created by Gizem Fitoz on 4.04.2021.
//

import Foundation
@testable import RickAndMorty

class CharacterDetailPresenterSpy: CharacterDetailPresentationLogic {
    var presentCharacterDetailCalled = false
    func presentCharacterDetail(response: CharacterDetail.Character.Response) {
        presentCharacterDetailCalled = true
    }
    
    var presentEpisodeCalled = false
    func presentEpisode(response: CharacterDetail.Episode.Response) {
        presentEpisodeCalled = true
    }
    
    var presentFavoriteCalled = false
    func presentFavorite(response: CharacterDetail.Favorite.Response) {
        presentFavoriteCalled = true
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
