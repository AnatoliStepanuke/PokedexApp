import Alamofire

final class APIManager {
    // MARK: - Properties
    var baseURL: String = "https://pokeapi.co/api/v2/pokemon"

    // MARK: - Init
    static let instance = APIManager()
    private init() { }

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
}
