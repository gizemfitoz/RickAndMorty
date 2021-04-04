//
//  CharacterDetailInteractorTests.swift
//  RickAndMortyTests
//
//  Created by Gizem Fitoz on 4.04.2021.
//

import XCTest
@testable import RickAndMorty

class CharacterDetailInteractorTests: XCTestCase {
    var interactor: CharacterDetailInteractor!
    var presenter: CharacterDetailPresenterSpy!
    var worker: CharacterDetailWorkerSpy!
    
    override func setUp() {
        interactor = CharacterDetailInteractor()
        presenter = CharacterDetailPresenterSpy()
        interactor.presenter = presenter
        worker = CharacterDetailWorkerSpy()
        interactor.worker = worker
    }
    
    func testFetchCharacter() {
        // Given
        interactor.characterId = 1
        // When
        interactor.fetchCharacter()
        // Then
        XCTAssertEqual(interactor.character?.name, "Rick Sanchez")
        XCTAssertEqual(interactor.character?.status, "Alive")
        XCTAssertEqual(interactor.character?.species, "Human")
        XCTAssertEqual(interactor.character?.gender, "Male")
        XCTAssertEqual(interactor.character?.episodes.count, 41)
        XCTAssertEqual(interactor.character?.origin.name, "Earth (C-137)")
        XCTAssertTrue(presenter.presentCharacterDetailCalled)
    }
    
    func testFetchCharacterWithError() {
        // Given
        worker.testErrorCase = true
        interactor.characterId = 1
        // When
        interactor.fetchCharacter()
        // Then
        XCTAssertNil(interactor.character)
        XCTAssertTrue(presenter.presentLoaderCalled)
        XCTAssertTrue(presenter.presentErrorCalled)
    }
    
    func testFetchEpisode() {
        // When
        interactor.fetchEpisode(url: "https://rickandmortyapi.com/api/character/671")
        // Then
        XCTAssertEqual(interactor.episode?.name, "Star Mort: Rickturn of the Jerri")
        XCTAssertEqual(interactor.episode?.airDate, "May 31, 2020")
        XCTAssertTrue(presenter.presentEpisodeCalled)
    }
    
    func testFetchEpisodeWithError() {
        // Given
        worker.testErrorCase = true
        // When
        interactor.fetchEpisode(url: "https://rickandmortyapi.com/api/character/671")
        // Then
        XCTAssertNil(interactor.episode)
        XCTAssertFalse(presenter.presentEpisodeCalled)
        XCTAssertTrue(presenter.presentLoaderCalled)
        XCTAssertTrue(presenter.presentErrorCalled)
    }
}
