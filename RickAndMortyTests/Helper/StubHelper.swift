//
//  StubHelper.swift
//  RickAndMortyTests
//
//  Created by Gizem Fitoz on 4.04.2021.
//

import Foundation
@testable import API

class StubHelper {
    static func getModel<T: Decodable>(from file: String, onSuccess: @escaping (T) -> Void, onError: @escaping (String) -> Void) {
        guard let data = loadData(file: file) else {
            onError("Error")
            return
        }
        let jsonDecoder = JSONDecoder()
        do {
            let model = try jsonDecoder.decode(T.self, from: data)
            onSuccess(model)
        } catch {
            onError("Error")
        }
    }
    
    static func loadData(file: String) -> Data? {
        let bundle = Bundle(for: self)

        guard let url = bundle.url(forResource: file, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }
}

