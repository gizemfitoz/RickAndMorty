//
//  CharacterDetailRouter.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation

protocol CharacterDetailRoutingLogic: AnyObject {
    
}

protocol CharacterDetailDataPassing: class {
    var dataStore: CharacterDetailDataStore? { get }
}

final class CharacterDetailRouter: CharacterDetailRoutingLogic, CharacterDetailDataPassing {
    
    weak var viewController: CharacterDetailViewController?
    var dataStore: CharacterDetailDataStore?
    
}
