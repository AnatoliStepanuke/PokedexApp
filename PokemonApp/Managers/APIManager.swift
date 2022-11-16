import Alamofire
import UIKit

final class APIManager {
    // MARK: - Enum
    enum AppError: Error {
        case networkError(message: String)
    }

    // MARK: - Properties
    private var baseURLEndPoint: String = Constants.baseURL + Constants.endPoint

    // MARK: - API
    func getPokemonsNextPage(completion: @escaping((Result<ServerModel, AppError>) -> Void)) {
        AF.request(Constants.baseURL + Constants.endPoint).responseDecodable(of: ServerModel.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
                self.baseURLEndPoint = data.nextPage
            case .failure(let error):
                completion(.failure(.networkError(message: error.localizedDescription)))
            }
        }
    }

    func getPokemonDetails(pokemonId: Int, completion: @escaping ((Result<PokemonDetails, AppError>) -> Void)) {
        AF.request(Constants.baseURL + Constants.endPointSlash + "\(pokemonId)")
            .responseDecodable(of: PokemonDetails.self) { response in
            switch response.result {
            case .success(let data): completion(.success(data))
            case .failure(let error): completion(.failure(.networkError(message: error.localizedDescription)))
            }
        }
    }

    func loadImage(imageLink: String, completion: @escaping ((Result<UIImage, AppError>) -> Void)) {
        DispatchQueue.global().async {
            guard let url = URL(string: imageLink) else { return }
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
            } catch {
                completion(.failure(.networkError(message: error.localizedDescription)))
            }
        }
    }
}
