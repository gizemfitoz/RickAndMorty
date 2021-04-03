//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import UIKit
import Extensions

protocol CharacterListDisplayLogic: AnyObject {
    func displayCharacters(viewModel: CharacterList.Characters.ViewModel)
    func displayToggleLayoutType(viewModel: CharacterList.ToggleLayoutType.ViewModel)
}

final class CharacterListViewController: UIViewController, StoryboardLoadable {
    @IBOutlet var charactersCollectionView: UICollectionView!
    var interactor: CharacterListBusinessLogic?
    var router: (CharacterListRoutingLogic & CharacterListDataPassing)?
    private var layoutBarButtonItem: UIBarButtonItem?
    private var characters: [CharacterList.Characters.ViewModel.Character] = []
    
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
        interactor?.getCharacters()
    }
    
    private func setupUI() {
        charactersCollectionView.register(
            UINib(nibName: "CharacterListCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "CharacterListCollectionViewCell")
        charactersCollectionView.register(
            UINib(nibName: "CharacterGridCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "CharacterGridCollectionViewCell")
        charactersCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)

        addLayoutBarButtonItem()
        setLayoutBarButtonItemImage(CharacterList.ToggleLayoutType.LayoutType.list.image)
    }
    
    private func addLayoutBarButtonItem() {
        layoutBarButtonItem = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(layoutBarButtonItemTapped(sender:)))
        navigationItem.rightBarButtonItem = layoutBarButtonItem
    }
    
    @objc private func layoutBarButtonItemTapped(sender: UIBarButtonItem) {
        interactor?.toggleLayoutType()
    }
    
    private func setLayoutBarButtonItemImage(_ image: UIImage?) {
        guard let image = image else { return }
        layoutBarButtonItem?.image = image
    }
}

extension CharacterListViewController: CharacterListDisplayLogic {
    func displayCharacters(viewModel: CharacterList.Characters.ViewModel) {
        characters = viewModel.characters
        charactersCollectionView.reloadData()
    }
    
    func displayToggleLayoutType(viewModel: CharacterList.ToggleLayoutType.ViewModel) {
        setLayoutBarButtonItemImage(viewModel.type.image)
        charactersCollectionView.reloadData()
    }
}

extension CharacterListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let layoutType = router?.dataStore?.layoutType ?? .list
        
        var identifier = ""
        if layoutType == .list {
            identifier = "CharacterListCollectionViewCell"
        } else {
            identifier = "CharacterGridCollectionViewCell"
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CharacterListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.set(viewModel: characters[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch router?.dataStore?.layoutType ?? .list {
        case .grid:
            return CGSize(
                width: (collectionView.frame.size.width - 15) / 2,
                height: CharacterList.ToggleLayoutType.LayoutType.grid.rowHeight)
        case .list:
            return CGSize(
                width: collectionView.frame.size.width,
                height: CharacterList.ToggleLayoutType.LayoutType.list.rowHeight)
        }
    }
}
