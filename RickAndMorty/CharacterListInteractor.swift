//
//  CharacterListInteractor.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation
import API

protocol CharacterListBusinessLogic: AnyObject {
    func fetchCharacters()
    func fetchLayoutType()
    func fetchCharacterDetail(id: Int)
    func fetchLastSelectedItem()
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
    
    func fetchCharacters() {
        if isPaginating || (totalPages != 0 && self.page == totalPages) {
            return
        }
        
        isPaginating = true
        self.page = self.page + 1
        
        self.presenter?.presentLoader(hide: false)
        worker.getCharacters(page: String(page)) { [weak self] response in
            guard let self = self else { return }
            self.presenter?.presentLoader(hide: true)
            self.isPaginating = false
            self.totalPages = response.info.pages
            self.presentPagedCharacters(characters: response.results)
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.presenter?.presentLoader(hide: true)
            self.presenter?.presentError(error: error)
        }
    }
    
    func presentPagedCharacters(characters: [CharactersResponse.Character]) {
        let response =  CharacterList.Characters.Response(
            pagedCharacters: characters.map {
                CharacterList.Character(
                    id: $0.id,
                    image: $0.image,
                    name: $0.name,
                    status: $0.status,
                    species: $0.species,
                    isFavorite: worker.isFavorite(id: $0.id))
            }
        )
        self.presenter?.presentPagedCharacters(response: response)
    }
        
    func fetchLayoutType() {
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
    
    func fetchLastSelectedItem() {
        guard let id = selectedCharacterId else { return }
        let isFavorite = worker.isFavorite(id: id)
        self.presenter?.presentLastSelectedItem(
            response: CharacterList.LastSelectedCharacter.Response(
                characterId: id,
                isFavorite: isFavorite
            )
        )
    }
}
