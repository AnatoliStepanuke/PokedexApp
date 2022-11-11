import Alamofire

final class APIManager {
    // MARK: - Enum
    // MARK: Private
    private enum Constants {
        static let baseURL: String = "https://pokeapi.co/api/v2/pokemon"
    }

    // MARK: - Type constant
    // MARK: Public
    static let instance = APIManager()

    // MARK: - Init
    private init() { }

    // MARK: - API
    static func getAllPokemons(completion: @escaping((Pokemon) -> Void)) {
        AF.request(Constants.baseURL).responseDecodable(of: Pokemon.self) { response in
            switch response.result {
            case .success(let data):
                print(data)
                completion(data)
            case .failure(let error): print(error)
            }
        }
    }
}
