//
//  CharacterListViewController+CollectionView.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 4.04.2021.
//

import UIKit

extension CharacterListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if characters.isEmpty {
            collectionView.setEmptyMessage("No characters")
        } else {
            collectionView.restore()
        }
        return characters.count
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > charactersCollectionView.contentSize.height - 100 - scrollView.frame.size.height {
            interactor?.fetchCharacters()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.fetchCharacterDetail(id: characters[indexPath.row].id)
    }
}
