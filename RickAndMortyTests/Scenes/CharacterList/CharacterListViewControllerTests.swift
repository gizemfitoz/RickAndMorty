//
//  CharacterListViewControllerTests.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 4.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import RickAndMorty

final class CharacterListViewControllerTests: XCTestCase {
    var viewController: CharacterListViewController!
    var interactor: CharacterListInteractor!
    var presenter: CharacterListPresenterSpy!
    var router: CharacterListRouterSpy!
    
    override func setUp() {
        super.setUp()
        viewController = UIStoryboard.loadViewController() as CharacterListViewController
        interactor = CharacterListInteractor()
        presenter = CharacterListPresenterSpy()
        interactor.presenter = presenter
        interactor.worker = CharacterListWorkerSpy()
        viewController.interactor = interactor
        router = CharacterListRouterSpy()
        router.dataStore = interactor
        viewController.router = router
        viewController.loadView()
        viewController.viewDidLoad()
    }
    
    func testRightBarButtonItemImage() {
        XCTAssertEqual(viewController.navigationItem.rightBarButtonItem?.image, CharacterList.ToggleLayoutType.LayoutType.list.image)
    }
    
    func testLayoutBarButtonItemTappedWhenCurrentTypeIsList() {
        // Given
        interactor.layoutType = .list
        guard let barButtonItem = viewController.navigationItem.rightBarButtonItem else {
            XCTFail()
            return
        }
        // When
        viewController.layoutBarButtonItemTapped(sender: barButtonItem)
        // Then
        XCTAssertEqual(interactor.layoutType, .grid)
        XCTAssertTrue(presenter.presentLayoutTypeCalled)
    }
    
    func testLayoutBarButtonItemTappedWhenCurrentTypeIsGrid() {
        // Given
        interactor.layoutType = .grid
        guard let barButtonItem = viewController.navigationItem.rightBarButtonItem else {
            XCTFail()
            return
        }
        // When
        viewController.layoutBarButtonItemTapped(sender: barButtonItem)
        // Then
        XCTAssertEqual(interactor.layoutType, .list)
        XCTAssertTrue(presenter.presentLayoutTypeCalled)
    }
    
    func testCharactersCollectionViewCellWhenLayoutTypeIsList() {
        // Given
        viewController.characters = [getCharacter()]
        // When
        let cell = viewController.collectionView(
            viewController.charactersCollectionView,
            cellForItemAt: IndexPath(row: 0, section: 0)
        ) as? CharacterListCollectionViewCell
        // Then
        XCTAssertEqual(cell?.nameLabel.text, "Rick Sanchez")
        XCTAssertEqual(cell?.statusLabel.text, CharacterList.Character.StatusType.alive.rawValue.capitalized)
        XCTAssertEqual(cell?.speciesLabel.text, "Human")
    }
    
    func testCharactersCollectionViewCellWhenLayoutTypeIsGrid() {
        // Given
        viewController.characters = [getCharacter()]
        viewController.router?.dataStore?.layoutType = .grid
        // When
        let cell = viewController.collectionView(
            viewController.charactersCollectionView,
            cellForItemAt: IndexPath(row: 0, section: 0)
        ) as? CharacterGridCollectionViewCell
        // Then
        XCTAssertEqual(cell?.nameLabel.text, "Rick Sanchez")
        XCTAssertEqual(cell?.statusLabel.text, CharacterList.Character.StatusType.alive.rawValue.capitalized)
        XCTAssertEqual(cell?.speciesLabel.text, "Human")
    }
    
    private func getCharacter() -> CharacterList.Character {
        return CharacterList.Character(id: 1,
                                       image: "",
                                       name: "Rick Sanchez",
                                       status: .alive,
                                       species: "Human",
                                       isFavorite: false)
    }
    
    func testRouteToCharacterDetail() {
        // Given
        viewController.characters = [getCharacter()]
        // When
        viewController.collectionView(viewController.charactersCollectionView,
                                      didSelectItemAt: IndexPath(row: 0, section: 0))
        // Then
        XCTAssertEqual(router.dataStore?.selectedCharacterId, 1)
        XCTAssertTrue(presenter.presentCharacterDetailCalled)
    }
    
    func testDisplayCharacterDetail() {
        // When
        viewController.displayCharacterDetail()
        // Then
        XCTAssertTrue(router.routeToCharacterDetailCalled)
    }
    
    func testDisplayCharacters() {
        // Given
        let characters = [getCharacter()]
        // When
        viewController.displayCharacters(viewModel: CharacterList.Characters.ViewModel(allCharacters: characters))
        // Then
        XCTAssertEqual(viewController.characters.count, characters.count)
        XCTAssertEqual(viewController.characters[0].name, characters[0].name)
    }
    
    func testDisplayLastSelectedItem() {
        // Given
        var character = getCharacter() // isFavorite: false
        viewController.characters = [character]
        // When
        character.isFavorite = true
        viewController.displayLastSelectedItem(viewModel: CharacterList.LastSelectedCharacter.ViewModel(character: character, index: 0))
        // Then
        XCTAssertTrue(viewController.characters[0].isFavorite)
    }
    
    func testSearchBarCancelButtonClicked() {
        // Given
        let searchBar = viewController.searchController.searchBar
        searchBar.selectedScopeButtonIndex = 2
        // When
        viewController.searchBarCancelButtonClicked(searchBar)
        // Then
        XCTAssertEqual(searchBar.selectedScopeButtonIndex, 0)
    }
}
