import Alamofire
import Foundation

public enum API {
    public static func getCharacters(page: String,
                          onSuccess: @escaping (CharactersResponse) -> Void,
                          onError: @escaping (String) -> Void) {
        let url = "https://rickandmortyapi.com/api/character?page=\(page)"
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "GET"
        
        AF.request(urlRequest)
            .validate()
            .responseDecodable(of: CharactersResponse.self) { response in
                guard let charactersResponse = response.value else {
                    onError("Error fething the characters!")
                    return
                }
                onSuccess(charactersResponse)
            }
    }
    
    public static func getCharacter(id: Int,
                                    onSuccess: @escaping (CharactersResponse.Character) -> Void,
                          onError: @escaping (String) -> Void) {
        let url = "https://rickandmortyapi.com/api/character/\(id)"
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "GET"

        AF.request(urlRequest)
            .validate()
            .responseDecodable(of: CharactersResponse.Character.self) { response in
                guard let characterResponse = response.value else {
                    onError("Error fething the character detail!")
                    return
                }
                onSuccess(characterResponse)
            }
    }

}
