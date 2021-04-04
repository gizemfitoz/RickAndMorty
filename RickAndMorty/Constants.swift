//
//  Constants.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 4.04.2021.
//

import UIKit

enum Constants {
    static let charcterListCell = "CharacterListCollectionViewCell"
    static let charcterLGridCell = "CharacterGridCollectionViewCell"
    static let listLayoutImage = UIImage(systemName: "rectangle.grid.1x2")
    static let gridLayoutImage = UIImage(systemName: "rectangle.grid.2x2")
    static let listRowHeight: CGFloat = 93
    static let gridRowHeight: CGFloat = 165
    static let noCharactersMessage = "No characters"
    static let characterCollectionViewContentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
    static let searchPlaceholderText = "Search Character..."
    static let favoritesUserDefaultsKey = "favorites"
    static let favoriteImage = UIImage(systemName: "star.fill")
    static let notFavoriteImage = UIImage(systemName: "star")
}
