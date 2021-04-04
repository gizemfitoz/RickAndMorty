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
        XCTAssertEqual(interactor.character?.name, TestConstants.characterName)
        XCTAssertEqual(interactor.character?.status, TestConstants.characterStatus)
        XCTAssertEqual(interactor.character?.species, TestConstants.characterSpecies)
        XCTAssertEqual(interactor.character?.gender, TestConstants.characterGender)
        XCTAssertEqual(interactor.character?.episodes.count, TestConstants.characterEpisodesCount)
        XCTAssertEqual(interactor.character?.origin.name, TestConstants.characterOriginLocationName)
        XCTAssertEqual(interactor.character?.location.name, TestConstants.characterLastKnownLocationName)
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
        interactor.fetchEpisode(url: TestConstants.episodeUrl)
        // Then
        XCTAssertEqual(interactor.episode?.name, TestConstants.episodeName)
        XCTAssertEqual(interactor.episode?.airDate, TestConstants.episodeAirDate)
        XCTAssertTrue(presenter.presentEpisodeCalled)
    }
    
    func testFetchEpisodeWithError() {
        // Given
        worker.testErrorCase = true
        // When
        interactor.fetchEpisode(url: TestConstants.episodeUrl)
        // Then
        XCTAssertNil(interactor.episode)
        XCTAssertFalse(presenter.presentEpisodeCalled)
        XCTAssertTrue(presenter.presentLoaderCalled)
        XCTAssertTrue(presenter.presentErrorCalled)
    }
}
