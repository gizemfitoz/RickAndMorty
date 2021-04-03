//
//  CharacterListInteractor.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation
import API

protocol CharacterListBusinessLogic: AnyObject {
    func getCharacters()
    func toggleLayoutType()
    func fetchCharacterDetail(id: Int)
}

protocol CharacterListDataStore: AnyObject {
    var page: Int! { get set }
    var layoutType: CharacterList.ToggleLayoutType.LayoutType! { get set }
    var selectedCharacterId: Int? { get set }
}

final class CharacterListInteractor: CharacterListBusinessLogic, CharacterListDataStore {
    var presenter: CharacterListPresentationLogic?
    var worker: CharacterListWorkingLogic = CharacterListWorker()
    var page: Int! = 0
    var totalPages: Int = 0
    var layoutType: CharacterList.ToggleLayoutType.LayoutType! = .list
    var isPaginating = false
    var selectedCharacterId: Int?
    
    func getCharacters() {
        if isPaginating || (totalPages != 0 && self.page == totalPages) {
            return
        }
        
        isPaginating = true
        self.page = self.page + 1
        
        worker.getCharacters(page: String(page)) { [weak self] (response) in
            guard let self = self else { return }
            self.isPaginating = false
            self.totalPages = response.info.pages
            self.presenter?.presentCharacters(
                response: CharacterList.Characters.Response(characters: response.results)
            )
        } onError: { [weak self] (error) in
            guard let self = self else { return }
            self.presenter?.presentError(error: error)
        }
    }
    
    func toggleLayoutType() {
        if layoutType == .list {
            layoutType = .grid
        } else {
            layoutType = .list
        }
        self.presenter?.presentToggleLayoutType(
            response: CharacterList.ToggleLayoutType.Response(type: layoutType)
        )
    }
    
    func fetchCharacterDetail(id: Int) {
        selectedCharacterId = id
        presenter?.presentCharacterDetail()
    }
}
