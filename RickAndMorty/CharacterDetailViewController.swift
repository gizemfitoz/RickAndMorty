//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import UIKit
import SDWebImage

protocol CharacterDetailDisplayLogic: AnyObject {
    func displayCharacterDetail(viewModel: CharacterDetail.Character.ViewModel)
    func displayEpisode(viewModel: CharacterDetail.Episode.ViewModel)
    func displayFavorite(viewModel: CharacterDetail.Favorite.ViewModel)
    func displayLoader(hide: Bool)
    func displayError(error: String)
}

final class CharacterDetailViewController: BaseViewController {
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var numberOfEpisodesLabel: UILabel!
    @IBOutlet weak var originLocationNameLabel: UILabel!
    @IBOutlet weak var lastKnownLocationLabel: UILabel!
    @IBOutlet weak var lastSeenEpisodeNameLabel: UILabel!
    @IBOutlet weak var lastSeenEpisodeAirDateLabel: UILabel!
    @IBOutlet weak var episodeStackView: UIStackView!
    var interactor: CharacterDetailBusinessLogic?
    var router: (CharacterDetailRoutingLogic & CharacterDetailDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = CharacterDetailInteractor()
        let presenter = CharacterDetailPresenter()
        let router = CharacterDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchCharacter()
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        interactor?.saveOrRemoveFavorite()
    }
}

extension CharacterDetailViewController: CharacterDetailDisplayLogic {
    func displayCharacterDetail(viewModel: CharacterDetail.Character.ViewModel) {
        setFavoriteImageView(isFavorite: viewModel.isFavorite)
        characterImageView.sd_setImage(with: URL(string: viewModel.image), completed: nil)
        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.status
        speciesLabel.text = viewModel.species
        genderLabel.text = viewModel.gender
        numberOfEpisodesLabel.text = viewModel.numberOfEpisodes
        originLocationNameLabel.text = viewModel.originLocationName
    }
    
    func displayEpisode(viewModel: CharacterDetail.Episode.ViewModel) {
        episodeStackView.isHidden = false
        lastSeenEpisodeNameLabel.text = viewModel.lastSeenEpisodeName
        lastSeenEpisodeAirDateLabel.text = viewModel.lastSeenEpisodeAirDate
    }
    
    func displayFavorite(viewModel: CharacterDetail.Favorite.ViewModel) {
        setFavoriteImageView(isFavorite: viewModel.isFavorite)
    }
    
    private func setFavoriteImageView(isFavorite: Bool) {
        let named = isFavorite ? "star.fill" : "star"
        favoriteImageView.image = UIImage(systemName: named)
    }
    
    func displayLoader(hide: Bool) {
        hide ? hideLoadingView() : showLoadingView()
    }
    
    func displayError(error: String) {
        showError(error: error)
    }
}
