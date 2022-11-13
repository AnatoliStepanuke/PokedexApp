import Alamofire

final class APIManager {
    static let instance = APIManager()

    // MARK: - Init
    private init() { }

    // MARK: - API
    static func getResults(completion: @escaping((Result) -> Void)) {
        AF.request(Constants.baseURL).responseDecodable(of: Result.self) { response in
            switch response.result {
            case .success(let data):
                print(response)
                completion(data)
            case .failure(let error): print(error)
            }
        }
    }
}
