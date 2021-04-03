//
//  CharacterListModels.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import UIKit
import API

enum CharacterList {
    enum Characters {
        struct Response {
            var characters: [CharactersResponse.Character]
        }
        
        struct ViewModel {
            var characters: [Character]
            
            struct Character {
                var image: String
                var name: String
                var status: String
                var species: String
                var isFavorited: Bool
            }
        }
    }
    
    enum ToggleLayoutType {
        struct Response {
            var type: LayoutType
        }
        
        struct ViewModel {
            var type: LayoutType
        }
        
        enum LayoutType {
            case list
            case grid
            
            var image: UIImage? {
                switch self {
                case .list:
                    return UIImage(systemName: "rectangle.grid.1x2")
                case .grid:
                    return UIImage(systemName: "rectangle.grid.2x2")
                }
            }
            
            var rowHeight: CGFloat {
                switch self {
                case .list:
                    return 93
                case .grid:
                    return 165
                }
            }
        }
    }
}
