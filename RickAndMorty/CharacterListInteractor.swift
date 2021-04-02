//
//  CharacterListInteractor.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation

protocol CharacterListBusinessLogic: AnyObject {
    
}

protocol CharacterListDataStore: AnyObject {
    
}

final class CharacterListInteractor: CharacterListBusinessLogic, CharacterListDataStore {
    
    var presenter: CharacterListPresentationLogic?
    var worker: CharacterListWorkingLogic = CharacterListWorker()
    
}
