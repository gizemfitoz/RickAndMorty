//
//  CharacterListRouter.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation

protocol CharacterListRoutingLogic: AnyObject {
    
}

protocol CharacterListDataPassing: class {
    var dataStore: CharacterListDataStore? { get }
}

final class CharacterListRouter: CharacterListRoutingLogic, CharacterListDataPassing {
    
    weak var viewController: CharacterListViewController?
    var dataStore: CharacterListDataStore?
    
}
