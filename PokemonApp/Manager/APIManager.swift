import Alamofire
import UIKit

final class APIManager {
    // MARK: - Properties
    var baseURL: String = "https://pokeapi.co/api/v2/pokemon"

    // MARK: - Init
    private init() { }
    static let instance = APIManager()

    // MARK: - API
    func getPokemonsNextPage(completion: @escaping((Result) -> Void)) {
        AF.request(baseURL).responseDecodable(of: Result.self) { response in
            switch response.result {
            case .success(let data):
                print(response)
                completion(data)
                self.baseURL = data.nextPage
            case .failure(let error): print(error)
            }
        }
    }

    func getPokemonDetails(pokemonId: Int, completion: @escaping ((PokemonDetails) -> Void)) {
        AF.request("https://pokeapi.co/api/v2/pokemon/\(pokemonId)/")
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
