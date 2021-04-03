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
}

protocol CharacterListDataStore: AnyObject {
    var page: Int! { get set }
    var layoutType: CharacterList.ToggleLayoutType.LayoutType! { get set }
}

final class CharacterListInteractor: CharacterListBusinessLogic, CharacterListDataStore {
    var presenter: CharacterListPresentationLogic?
    var worker: CharacterListWorkingLogic = CharacterListWorker()
    var page: Int! = 1
    var layoutType: CharacterList.ToggleLayoutType.LayoutType! = .list
    
    func getCharacters() {
        worker.getCharacters(page: String(page)) { [weak self] (response) in
            guard let self = self else { return }
            self.presenter?.presentCharacters(
                response: CharacterList.Characters.Response(characters: response.results)
            )
        } onError: { [weak self] (error) in
            print("\(error)")  // TODO update
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
}
