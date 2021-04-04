//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import UIKit

protocol CharacterListDisplayLogic: AnyObject {
    func displayCharacters(viewModel: CharacterList.Characters.ViewModel)
    func displayLayoutType(viewModel: CharacterList.ToggleLayoutType.ViewModel)
    func displayCharacterDetail()
    func displayLastSelectedItem(viewModel: CharacterList.LastSelectedCharacter.ViewModel)
    func displayLoader(hide: Bool)
    func displayError(error: String)
}

final class CharacterListViewController: BaseViewController {
    @IBOutlet var charactersCollectionView: UICollectionView!
    var interactor: CharacterListBusinessLogic?
    var router: (CharacterListRoutingLogic & CharacterListDataPassing)?
    var characters: [CharacterList.Character] = []
    var searchController = UISearchController()
    private var layoutBarButtonItem: UIBarButtonItem?
            
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
        let interactor = CharacterListInteractor()
        let presenter = CharacterListPresenter()
        let router = CharacterListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearch()
        interactor?.fetchCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchLastSelectedItem()
    }
    
    private func setupUI() {
        charactersCollectionView.register(cell: Constants.charcterListCell)
        charactersCollectionView.register(cell: Constants.charcterLGridCell)
        charactersCollectionView.contentInset = Constants.characterCollectionViewContentInset
        
        addLayoutBarButtonItem()
        setLayoutBarButtonItemImage(CharacterList.ToggleLayoutType.LayoutType.list.image)
    }
    
    private func setupSearch() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.returnKeyType = .done
        searchController.searchBar.placeholder = Constants.searchPlaceholderText
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = CharacterList.Character.StatusType.allValues
        searchController.isActive = true
    }
    
    private func addLayoutBarButtonItem() {
        layoutBarButtonItem = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(layoutBarButtonItemTapped(sender:)))
        navigationItem.rightBarButtonItem = layoutBarButtonItem
    }
    
    @objc func layoutBarButtonItemTapped(sender: UIBarButtonItem) {
        interactor?.fetchLayoutType()
    }
    
    private func setLayoutBarButtonItemImage(_ image: UIImage?) {
        guard let image = image else { return }
        layoutBarButtonItem?.image = image
    }
}

extension CharacterListViewController: CharacterListDisplayLogic {
    func displayCharacters(viewModel: CharacterList.Characters.ViewModel) {
        characters = viewModel.allCharacters
        charactersCollectionView.reloadData()
    }
    
    func displayLayoutType(viewModel: CharacterList.ToggleLayoutType.ViewModel) {
        setLayoutBarButtonItemImage(viewModel.type.image)
        charactersCollectionView.reloadData()
    }
    
    func displayCharacterDetail() {
        router?.routeToCharacterDetail()
    }
    
    func displayLastSelectedItem(viewModel: CharacterList.LastSelectedCharacter.ViewModel) {
        characters[viewModel.index] = viewModel.character
        charactersCollectionView.reloadItems(at: [IndexPath(item: viewModel.index, section: 0)])
    }
    
    func displayLoader(hide: Bool) {
        hide ? hideLoadingView() : showLoadingView()
    }
    
    func displayError(error: String) {
        showError(error: error)
    }
}
