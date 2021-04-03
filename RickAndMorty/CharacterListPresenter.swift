//
//  CharacterListPresenter.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation

protocol CharacterListPresentationLogic: AnyObject {
    func presentCharacters(response: CharacterList.Characters.Response)
    func presentToggleLayoutType(response: CharacterList.ToggleLayoutType.Response)
    func presentCharacterDetail()
    func presentLoader(hide: Bool)
    func presentError(error: String)
}

final class CharacterListPresenter: CharacterListPresentationLogic {
    
    weak var viewController: CharacterListDisplayLogic?
    
    func presentToggleLayoutType(response: CharacterList.ToggleLayoutType.Response) {
        self.viewController?.displayToggleLayoutType(
            viewModel: CharacterList.ToggleLayoutType.ViewModel(type: response.type)
        )
    }
    
    func presentCharacters(response: CharacterList.Characters.Response) {
        let characters = response.characters.map {
            CharacterList.Characters.ViewModel.Character(
                id: $0.id,
                image: $0.image,
                name: $0.name,
                status: $0.status,
                species: $0.species,
                isFavorited: true) // TODO update favorite
        }
        
        let viewModel = CharacterList.Characters.ViewModel(characters: characters)
        viewController?.displayCharacters(viewModel: viewModel)
    }
    
    func presentCharacterDetail() {
        viewController?.displayCharacterDetail()
    }
    
    func presentLoader(hide: Bool) {
        viewController?.displayLoader(hide: hide)
    }
    
    func presentError(error: String) {
        viewController?.displayError(error: error)
    }
}
