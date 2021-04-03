//
//  CharacterListPresenter.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation

protocol CharacterListPresentationLogic: AnyObject {
    func presentPagedCharacters(response: CharacterList.Characters.Response)
    func presentToggleLayoutType(response: CharacterList.ToggleLayoutType.Response)
    func presentCharacterDetail()
    func presentLastSelectedItem(response: CharacterList.LastSelectedCharacter.Response)
    func presentLoader(hide: Bool)
    func presentError(error: String)
}

final class CharacterListPresenter: CharacterListPresentationLogic {
    
    weak var viewController: CharacterListDisplayLogic?
    var characters: [CharacterList.Character] = [] {
        didSet {
            self.charactersIndexDict = self.characters.enumerated()
                .reduce(into: [:]) { (dict, tuple: (index: Int, character: CharacterList.Character)) in
                dict[tuple.character.id] = tuple.index
            }
        }
    }
    var charactersIndexDict: [Int: Int] = [:] // Id:Index
    
    func presentToggleLayoutType(response: CharacterList.ToggleLayoutType.Response) {
        self.viewController?.displayToggleLayoutType(
            viewModel: CharacterList.ToggleLayoutType.ViewModel(type: response.type)
        )
    }
    
    func presentPagedCharacters(response: CharacterList.Characters.Response) {
        self.characters.append(contentsOf: response.pagedCharacters)
        
        let viewModel = CharacterList.Characters.ViewModel(allCharacters: self.characters)
        viewController?.displayCharacters(viewModel: viewModel)
    }
    
    func presentCharacterDetail() {
        viewController?.displayCharacterDetail()
    }
    
    func presentLastSelectedItem(response: CharacterList.LastSelectedCharacter.Response) {
        guard let characterIndex = self.charactersIndexDict[response.characterId] else { return }
        var character = self.characters[characterIndex]
        character.isFavorite = response.isFavorite
        
        viewController?.displayLastSelectedItem(
            viewModel: CharacterList.LastSelectedCharacter.ViewModel(
                character: character,
                index: characterIndex))
    }
    
    func presentLoader(hide: Bool) {
        viewController?.displayLoader(hide: hide)
    }
    
    func presentError(error: String) {
        viewController?.displayError(error: error)
    }
}
