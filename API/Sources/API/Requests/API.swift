import Alamofire
import Foundation

public enum API {
    public static func getCharacters(page: String,
                          onSuccess: @escaping (CharactersResponse) -> Void,
                          onError: @escaping (String) -> Void) {
        let url = "https://rickandmortyapi.com/api/character"
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(page, forHTTPHeaderField: "page")
        
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
}
