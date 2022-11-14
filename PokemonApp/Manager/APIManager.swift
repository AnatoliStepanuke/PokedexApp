import Alamofire

final class APIManager {
    static let instance = APIManager()

    // MARK: - Init
    private init() { }

    // MARK: - API
    func getPokemonsNextPage(completion: @escaping((Result) -> Void)) {
        AF.request(Constants.baseURL).responseDecodable(of: Result.self) { response in
            switch response.result {
            case .success(let data):
                print(response)
                completion(data)
                Constants.baseURL = data.nextPage
            case .failure(let error): print(error)
            }
        }
    }
}
