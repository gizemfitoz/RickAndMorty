import Alamofire
import Foundation

public enum API {
    private static let session = Session(eventMonitors: [APILogger()])
    
    public static func getCharacters(page: String,
                                     name: String,
                                     status: String,
                                     onSuccess: @escaping (CharactersResponse) -> Void,
                                     onError: @escaping (String) -> Void) {
        let url = "https://rickandmortyapi.com/api/character"
        
        var parameters: [String:String] = [:]
        
        parameters["page"] = page
        
        if !name.isEmpty {
            parameters["name"] = name
        }
        if !status.isEmpty {
            parameters["status"] = status
        }
        
        session.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: CharactersResponse.self) { response in
                guard let charactersResponse = response.value else {
                    onError("Error fetching the characters page #\(page)!")
                    return
                }
                onSuccess(charactersResponse)
            }
    }
    
    public static func getCharacter(id: Int,
                                    onSuccess: @escaping (CharactersResponse.Character) -> Void,
                                    onError: @escaping (String) -> Void) {
        let url = "https://rickandmortyapi.com/api/character/\(id)"
        session.request(url, method: .get)
            .validate()
            .responseDecodable(of: CharactersResponse.Character.self) { response in
                guard let characterResponse = response.value else {
                    onError("Error fetching the character detail!")
                    return
                }
                onSuccess(characterResponse)
            }
    }
    
    public static func getEpisode(url: String,
                                  onSuccess: @escaping (EpisodeResponse) -> Void,
                                  onError: @escaping (String) -> Void) {
        session.request(url, method: .get)
            .validate()
            .responseDecodable(of: EpisodeResponse.self) { response in
                guard let episode = response.value else {
                    onError("Error fetching the episode!")
                    return
                }
                onSuccess(episode)
            }
    }
}
