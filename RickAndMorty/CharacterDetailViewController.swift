//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import UIKit
import Extensions

protocol CharacterDetailDisplayLogic: AnyObject {
    
}

final class CharacterDetailViewController: UIViewController, StoryboardLoadable {
    
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
}

extension CharacterDetailViewController: CharacterDetailDisplayLogic {
    
}
