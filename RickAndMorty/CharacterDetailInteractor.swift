//
//  CharacterDetailInteractor.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation

protocol CharacterDetailBusinessLogic: AnyObject {
    func fetchCharacter()
    func saveOrRemoveFavorite()
}

protocol CharacterDetailDataStore: AnyObject {
    var characterId: Int! { get set }
}

final class CharacterDetailInteractor: CharacterDetailBusinessLogic, CharacterDetailDataStore {
    var presenter: CharacterDetailPresentationLogic?
    var worker: CharacterDetailWorkingLogic = CharacterDetailWorker()
    var characterId: Int!
    var isFavorite = false
    
    func fetchCharacter() {
        self.presenter?.presentLoader(hide: false)
        worker.getCharacter(id: characterId) { [weak self] response in
            guard let self = self else { return }
            self.isFavorite = self.worker.isFavorite(id: response.id)
            
            self.presenter?.presentCharacterDetail(
                response: CharacterDetail.Character.Response(character: response, isFavorite: self.isFavorite)
            )
            
            guard let lastEpisodeUrl = response.episodes.last else { return }
            self.fetchEpisode(url: lastEpisodeUrl)
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.presenter?.presentLoader(hide: true)
            self.presenter?.presentError(error: error)
        }
    }
    
    func fetchEpisode(url: String) {
        worker.getEpisode(url: url) { [weak self] response in
            guard let self = self else { return }
            self.presenter?.presentLoader(hide: true)
            self.presenter?.presentEpisode(
                response: CharacterDetail.Episode.Response(episode: response)
            )
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.presenter?.presentLoader(hide: true)
            self.presenter?.presentError(error: error)
        }
    }
    
    func saveOrRemoveFavorite() {
        if isFavorite {
            worker.removeFavorite(id: characterId)
        } else {
            worker.saveFavorite(id: characterId)
        }
        isFavorite = !isFavorite
        presenter?.presentFavorite(
            response: CharacterDetail.Favorite.Response(isFavorite: isFavorite))
    }
}
