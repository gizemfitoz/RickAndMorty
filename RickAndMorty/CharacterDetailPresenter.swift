//
//  CharacterDetailPresenter.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation

protocol CharacterDetailPresentationLogic: AnyObject {
    
}

final class CharacterDetailPresenter: CharacterDetailPresentationLogic {
    
    weak var viewController: CharacterDetailDisplayLogic?
    
}
