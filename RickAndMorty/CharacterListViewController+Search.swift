//
//  CharacterListViewController+Search.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 4.04.2021.
//

import UIKit

extension CharacterListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let value = searchBar.scopeButtonTitles![selectedScope]
        let status = CharacterList.Character.StatusType(rawValue: value.lowercased()) ?? .all
        filterContentForSearchText(searchText: searchBar.text!, status: status)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.selectedScopeButtonIndex = 0
        interactor?.cancelFilter()
    }
}

extension CharacterListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let value = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let status = CharacterList.Character.StatusType(rawValue: value.lowercased()) ?? .all
        filterContentForSearchText(searchText: searchBar.text!, status: status)
    }
    
    func filterContentForSearchText(searchText: String,
                                    status: CharacterList.Character.StatusType) {
        let request = CharacterList.Filter.Request(name: searchText, status: status)
        interactor?.filterCharactersWith(request: request)
    }
}
