//
//  CharactersResponse.swift
//  
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation

public struct CharactersResponse: Decodable {
    public let info: Info
    public let results: [Character]
    
    public struct Info: Decodable {
        public var count: Int
        public var pages: Int
    }
    
    public struct Character: Decodable {
        public let id: Int
        public let name: String
        public let status: String
        public let species: String
        public let type: String
        public let gender: String
        public let origin: Location
        public let location: Location
        public let image: String
        public let episodes: [String]
        public let url: String
        public let created: String
        
        enum CodingKeys: String, CodingKey {
            case id, name, status, species, type, gender, origin, location, image, url, created
            case episodes = "episode"
        }
    }
    
    public struct Location: Decodable {
        public let name: String
        public let url: String
    }
}
