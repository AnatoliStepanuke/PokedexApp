import Alamofire

final class APIManager {
    private enum Constants {
        static let baseURL: String = "https://pokeapi.co/api/v2/pokemon"
    }
    static let instance = APIManager()

    // MARK: - Init
    private init() { }

    // MARK: - API
    static func getAllPokemons(completion: @escaping((Pokemon) -> Void)) {
        AF.request(Constants.baseURL).responseDecodable(of: Pokemon.self) { response in
            switch response.result {
            case .success(let data): completion(data)
            case .failure(let error): print(error)
            }
        }
    }
}
