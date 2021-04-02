//
//  CharactersResponse.swift
//  
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation

public struct CharactersResponse: Decodable {
    let info: Info
    let results: [Character]
    
    public struct Info: Decodable {
        public var count: Int
        public var pages: Int
    }
    
    public struct Character: Decodable {
        let id: Int
        let name: String
        let status: String
        let species: String
        let type: String
        let gender: String
        let origin: Location
        let location: Location
        let image: String
        let episode: [String]
        let url: String
        let created: String
    }
    
    public struct Location: Decodable {
        let name: String
        let url: String
    }
}
