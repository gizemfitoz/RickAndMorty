//
//  CharacterDetailViewControllerTests.swift
//  RickAndMortyTests
//
//  Created by Gizem Fitoz on 4.04.2021.
//

import XCTest
@testable import RickAndMorty

class CharacterDetailViewControllerTests: XCTestCase {
    var viewController: CharacterDetailViewController!
    var interactor: CharacterDetailInteractor!
    var presenter: CharacterDetailPresenterSpy!
    
    override func setUp() {
        super.setUp()
        viewController = UIStoryboard.loadViewController() as CharacterDetailViewController
        interactor = CharacterDetailInteractor()
        presenter = CharacterDetailPresenterSpy()
        interactor.presenter = presenter
        interactor.worker = CharacterDetailWorkerSpy()
        viewController.interactor = interactor
        viewController.loadView()
    }
    
    func testFetchCharacter() {
        // Given
        interactor.characterId = TestConstants.characterId
        // Then
        viewController.viewDidLoad()
        // Then
        XCTAssertEqual(interactor.character?.id, 1)
        XCTAssertEqual(interactor.character?.name, TestConstants.characterName)
        XCTAssertEqual(interactor.character?.episodes.count, TestConstants.characterEpisodesCount)
        XCTAssertTrue(presenter.presentCharacterDetailCalled)
    }
    
    func testFavoriteButtonClickedWhenCurrentStateIsFavorite() {
        // Given
        interactor.characterId = TestConstants.characterId
        interactor.worker.saveFavorite(id: TestConstants.characterId)
        interactor.isFavorite = true
        // When
        viewController.favoriteButtonClicked(UIButton())
        // Then
        XCTAssertFalse(interactor.isFavorite)
        XCTAssertFalse(interactor.worker.isFavorite(id: TestConstants.characterId))
        XCTAssertTrue(presenter.presentFavoriteCalled)
    }
    
    func testFavoriteButtonClickedWhenCurrentStateIsNotFavorite() {
        // Given
        interactor.characterId = TestConstants.characterId
        interactor.worker.removeFavorite(id: TestConstants.characterId)
        interactor.isFavorite = false
        // When
        viewController.favoriteButtonClicked(UIButton())
        // Then
        XCTAssertTrue(interactor.isFavorite)
        XCTAssertTrue(interactor.worker.isFavorite(id: TestConstants.characterId))
        XCTAssertTrue(presenter.presentFavoriteCalled)
    }
    
    func testDisplayCharacterDetail() {
        // When
        viewController.displayCharacterDetail(viewModel: CharacterDetail.Character.ViewModel(
                                                isFavorite: false,
                                                image: "",
                                                name: TestConstants.characterName,
                                                status: TestConstants.characterStatus,
                                                species: TestConstants.characterSpecies,
                                                gender: TestConstants.characterGender,
                                                numberOfEpisodes: "\(TestConstants.characterEpisodesCount)",
                                                originLocationName: TestConstants.characterOriginLocationName,
                                                lastKnownLocationName: TestConstants.characterLastKnownLocationName))
        // Then
        XCTAssertEqual(viewController.nameLabel.text, TestConstants.characterName)
        XCTAssertEqual(viewController.statusLabel.text, TestConstants.characterStatus)
        XCTAssertEqual(viewController.speciesLabel.text, TestConstants.characterSpecies)
        XCTAssertEqual(viewController.genderLabel.text, TestConstants.characterGender)
        XCTAssertEqual(viewController.numberOfEpisodesLabel.text, "\(TestConstants.characterEpisodesCount)")
        XCTAssertEqual(viewController.originLocationNameLabel.text, TestConstants.characterOriginLocationName)
        XCTAssertEqual(viewController.lastKnownLocationLabel.text, TestConstants.characterLastKnownLocationName)
    }
    
    func testDisplayEpisode() {
        // When
        viewController.displayEpisode(viewModel: CharacterDetail.Episode.ViewModel(
                                        lastSeenEpisodeName: TestConstants.episodeName,
                                        lastSeenEpisodeAirDate: TestConstants.episodeAirDate))
        // Then
        XCTAssertFalse(viewController.episodeStackView.isHidden)
        XCTAssertEqual(viewController.lastSeenEpisodeNameLabel.text, TestConstants.episodeName)
        XCTAssertEqual(viewController.lastSeenEpisodeAirDateLabel.text, TestConstants.episodeAirDate)
    }
}
