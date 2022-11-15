import Alamofire
import UIKit

final class APIManager {
    // MARK: - Properties
    private var baseURLEndPoint: String = Constants.baseURL + Constants.endPoint

    // MARK: - API
    func getPokemonsNextPage(completion: @escaping((Result) -> Void)) {
        AF.request(Constants.baseURL + Constants.endPoint).responseDecodable(of: Result.self) { response in
            switch response.result {
            case .success(let data):
                print(response)
                completion(data)
                self.baseURLEndPoint = data.nextPage
            case .failure(let error): print(error)
            }
        }
    }

    func getPokemonDetails(pokemonId: Int, completion: @escaping ((PokemonDetails) -> Void)) {
        AF.request(Constants.baseURL + Constants.endPointSlash + "\(pokemonId)")
            .responseDecodable(of: PokemonDetails.self) { response in
                print(response)
            switch response.result {
            case .success(let data): completion(data)
            case .failure(let error): print(error)
            }
        }
    }

    func loadImage(imageLink: String, completion: @escaping ((UIImage) -> Void)) {
        DispatchQueue.global().async {
            guard let url = URL(string: imageLink) else { return }
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    completion(image)
                }
            } catch {
                print(error)
            }
        }
    }
}
