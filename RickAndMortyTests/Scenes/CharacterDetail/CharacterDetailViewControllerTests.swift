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
        interactor.characterId = 1
        // Then
        viewController.viewDidLoad()
        // Then
        XCTAssertEqual(interactor.character?.id, 1)
        XCTAssertEqual(interactor.character?.name, "Rick Sanchez")
        XCTAssertEqual(interactor.character?.episodes.count, 41)
        XCTAssertTrue(presenter.presentCharacterDetailCalled)
    }
    
    func testFavoriteButtonClickedWhenCurrentStateIsFavorite() {
        // Given
        let id = 1
        interactor.characterId = id
        interactor.worker.saveFavorite(id: id)
        interactor.isFavorite = true
        // When
        viewController.favoriteButtonClicked(UIButton())
        // Then
        XCTAssertFalse(interactor.isFavorite)
        XCTAssertFalse(interactor.worker.isFavorite(id: id))
        XCTAssertTrue(presenter.presentFavoriteCalled)
    }
    
    func testFavoriteButtonClickedWhenCurrentStateIsNotFavorite() {
        // Given
        let id = 1
        interactor.characterId = id
        interactor.worker.removeFavorite(id: id)
        interactor.isFavorite = false
        // When
        viewController.favoriteButtonClicked(UIButton())
        // Then
        XCTAssertTrue(interactor.isFavorite)
        XCTAssertTrue(interactor.worker.isFavorite(id: id))
        XCTAssertTrue(presenter.presentFavoriteCalled)
    }
    
    func testDisplayCharacterDetail() {
        // When
        viewController.displayCharacterDetail(viewModel: CharacterDetail.Character.ViewModel(
                                                isFavorite: false,
                                                image: "",
                                                name: "Rick Sanchez",
                                                status: "Alive",
                                                species: "Human",
                                                gender: "Male",
                                                numberOfEpisodes: "41",
                                                originLocationName:  "Earth (C-137)",
                                                lastKnownLocationName: "Earth (Replacement Dimension)"))
        // Then
        XCTAssertEqual(viewController.nameLabel.text, "Rick Sanchez")
        XCTAssertEqual(viewController.statusLabel.text, "Alive")
        XCTAssertEqual(viewController.speciesLabel.text, "Human")
        XCTAssertEqual(viewController.genderLabel.text, "Male")
        XCTAssertEqual(viewController.numberOfEpisodesLabel.text, "41")
        XCTAssertEqual(viewController.originLocationNameLabel.text, "Earth (C-137)")
    }
    
    func testDisplayEpisode() {
        // When
        viewController.displayEpisode(viewModel: CharacterDetail.Episode.ViewModel(
                                        lastSeenEpisodeName: "Star Mort: Rickturn of the Jerri",
                                        lastSeenEpisodeAirDate: "May 31, 2020"))
        // Then
        XCTAssertFalse(viewController.episodeStackView.isHidden)
        XCTAssertEqual(viewController.lastSeenEpisodeNameLabel.text, "Star Mort: Rickturn of the Jerri")
        XCTAssertEqual(viewController.lastSeenEpisodeAirDateLabel.text, "May 31, 2020")
    }
}
