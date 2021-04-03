//
//  CharacterDetailInteractor.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation

protocol CharacterDetailBusinessLogic: AnyObject {
    
}

protocol CharacterDetailDataStore: AnyObject {
    var characterId: Int! { get set }
}

final class CharacterDetailInteractor: CharacterDetailBusinessLogic, CharacterDetailDataStore {
    var presenter: CharacterDetailPresentationLogic?
    var worker: CharacterDetailWorkingLogic = CharacterDetailWorker()
    var characterId: Int!

}
