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
}

protocol CharacterListDataStore: AnyObject {
    var page: Int? { get set }
}

final class CharacterListInteractor: CharacterListBusinessLogic, CharacterListDataStore {
    var presenter: CharacterListPresentationLogic?
    var worker: CharacterListWorkingLogic = CharacterListWorker()
    var page: Int? = 1
    
    func getCharacters() {
        guard let page = page else { return }
        
        worker.getCharacters(page: "\(page)") { [weak self] (response) in
            print("\(response)") // TODO update
        } onError: { [weak self] (error) in
            print("\(error)")  // TODO update
        }
    }
}
