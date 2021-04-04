//
//  CharacterListModels.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import UIKit
import API

enum CharacterList {
    
    struct Character {
        var id: Int
        var image: String
        var name: String
        var status: StatusType
        var species: String
        var isFavorite: Bool
        
        enum StatusType: String {
            case all = ""
            case alive
            case dead
            case unknown
            static let allValues = ["All", "Alive", "Dead", "Unknown"]
        }
    }
    
    enum Characters {
        struct Response {
            var pagedCharacters: [Character]
        }
        
        struct ViewModel {
            var allCharacters: [Character]
        }
    }
    
    enum LastSelectedCharacter {
        struct Response {
            var characterId: Int
            var isFavorite: Bool
        }
        
        struct ViewModel {
            var character: Character
            var index: Int
        }
    }
    
    enum Filter {
        struct Request {
            var name: String
            var status: Character.StatusType
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
                    return Constants.listLayoutImage
                case .grid:
                    return Constants.gridLayoutImage
                }
            }
            
            var rowHeight: CGFloat {
                switch self {
                case .list:
                    return Constants.listRowHeight
                case .grid:
                    return Constants.gridRowHeight
                }
            }
        }
    }
}
