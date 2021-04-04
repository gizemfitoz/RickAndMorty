//
//  CharacterListInteractorTests.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 4.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import RickAndMorty
import XCTest

final class CharacterListInteractorTests: XCTestCase {
    var interactor: CharacterListInteractor!
    var presenter: CharacterListPresenterSpy!
    var worker: CharacterListWorkerSpy!
    
    override func setUp() {
        interactor = CharacterListInteractor()
        presenter = CharacterListPresenterSpy()
        interactor.presenter = presenter
        worker = CharacterListWorkerSpy()
        interactor.worker = worker
    }
    
    func testFetchCharacters() {
        // Given
        interactor.page = 0
        // When
        interactor.fetchCharacters()
        // Then
        XCTAssertEqual(interactor.page, 1)
        XCTAssertEqual(interactor.totalPages, 34)
        XCTAssertFalse(interactor.isPaginating)
        XCTAssertTrue(presenter.presentPagedCharactersCalled)
        XCTAssertTrue(presenter.presentLoaderCalled)
    }
    
    
    func testFetchCharactersWhenIsPaginating() {
        // Given
        interactor.page = 0
        interactor.isPaginating = true
        // When
        interactor.fetchCharacters()
        // Then
        XCTAssertEqual(interactor.page, 0)
        XCTAssertEqual(interactor.totalPages, 0)
        XCTAssertTrue(interactor.isPaginating)
        XCTAssertFalse(presenter.presentLoaderCalled)
    }
    
    func testFetchCharactersWhenLastPage() {
        // Given
        interactor.totalPages = 34
        interactor.page = 34
        // When
        interactor.fetchCharacters()
        // Then
        XCTAssertEqual(interactor.page, 34)
        XCTAssertFalse(presenter.presentLoaderCalled)
    }
    
    func testFetchCharactersWhenError() {
        // When
        worker.testErrorCase = true
        interactor.fetchCharacters()
        // Then
        XCTAssertEqual(interactor.totalPages, 0)
        XCTAssertFalse(presenter.presentPagedCharactersCalled)
        XCTAssertFalse(interactor.isPaginating)
        XCTAssertTrue(presenter.presentLoaderCalled)
    }
    
    func testFetchLayoutTypeWhenCurrentTypeIsList() {
        // Given
        interactor.layoutType = .list
        // When
        interactor.fetchLayoutType()
        // Then
        XCTAssertEqual(interactor.layoutType, .grid)
        XCTAssertTrue(presenter.presentLayoutTypeCalled)
    }
    
    func testFetchLayoutTypeWhenCurrentTypeIsGrid() {
        // Given
        interactor.layoutType = .grid
        // When
        interactor.fetchLayoutType()
        // Then
        XCTAssertEqual(interactor.layoutType, .list)
        XCTAssertTrue(presenter.presentLayoutTypeCalled)
    }
    
}
