//
//  EpisodeResponse.swift
//  
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import Foundation

public struct EpisodeResponse: Decodable {
    public let name: String
    public let airDate: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case airDate = "air_date"
    }
}
