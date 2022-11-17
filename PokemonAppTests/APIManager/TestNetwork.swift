import Alamofire
import UIKit

final class TestNetwork {
    // MARK: - Enum
    enum AppError: Error {
        case networkError(message: String)
    }

    // MARK: - Models
    struct ServerModel: Codable {
        let nextPage: String
        let results: [Pokemon]
    }

    struct Pokemon: Codable {
        let name: String
    }

    // MARK: - Pokemon Details
    struct PokemonDetails: Codable {
        let height: Int
        let name: String
        let weight: Int
    }
    // MARK: - Properties
    private var baseURL: String = "https://pokeapi.co/api/v2/pokemon"
    private var baseURLEndPointSlash: String = "https://pokeapi.co/api/v2/pokemon/"

    // MARK: - API
    func getPokemonList(completion: @escaping((Result<ServerModel, AppError>) -> Void)) {
        AF.request(baseURL).responseDecodable(of: ServerModel.self) { [weak self] response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
                self?.baseURL = data.nextPage
            case .failure(let error):
                completion(.failure(.networkError(message: error.localizedDescription)))
            }
        }
    }

    func getPokemonDetails(pokemonId: Int, completion: @escaping ((Result<PokemonDetails, AppError>) -> Void)) {
        AF.request(baseURLEndPointSlash + "\(pokemonId)/")
            .responseDecodable(of: PokemonDetails.self) { response in
            switch response.result {
            case .success(let data): completion(.success(data))
            case .failure(let error): completion(.failure(.networkError(message: error.localizedDescription)))
            }
        }
    }
}
