//
//  CharacterListRouter.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import UIKit

protocol CharacterListRoutingLogic: AnyObject {
    func routeToCharacterDetail()
}

protocol CharacterListDataPassing: class {
    var dataStore: CharacterListDataStore? { get }
}

final class CharacterListRouter: CharacterListRoutingLogic, CharacterListDataPassing {
    
    weak var viewController: CharacterListViewController?
    var dataStore: CharacterListDataStore?
    
    func routeToCharacterDetail() {
        guard let id = dataStore?.selectedCharacterId else { return }
        
        let detailViewController = UIStoryboard.loadViewController() as CharacterDetailViewController
        detailViewController.router?.dataStore?.characterId = id
        self.viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
