//
//  CharacterDetailPresenter.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation
import API

protocol CharacterDetailPresentationLogic: AnyObject {
    func presentCharacterDetail(response: CharacterDetail.Character.Response)
    func presentEpisode(response: CharacterDetail.Episode.Response)
    func presentLoader(hide: Bool)
    func presentError(error: String)
}

final class CharacterDetailPresenter: CharacterDetailPresentationLogic {
    
    weak var viewController: CharacterDetailDisplayLogic?
    
    func presentCharacterDetail(response: CharacterDetail.Character.Response) {
        viewController?.displayCharacterDetail(
            viewModel: CharacterDetail.Character.ViewModel(
                image: response.character.image,
                name: response.character.name,
                status: response.character.status,
                species: response.character.species,
                gender: response.character.gender,
                numberOfEpisodes: "\(response.character.episodes.count)",
                originLocationName: response.character.origin.name,
                lastKnownLocationName: response.character.location.name))
    }
    
    func presentEpisode(response: CharacterDetail.Episode.Response) {
        viewController?.displayEpisode(
            viewModel: CharacterDetail.Episode.ViewModel(
                lastSeenEpisodeName: response.episode.name,
                lastSeenEpisodeAirDate: response.episode.airDate))
    }
    
    func presentLoader(hide: Bool) {
        viewController?.displayLoader(hide: hide)
    }
    
    func presentError(error: String) {
        viewController?.displayError(error: error)
    }
}
