import Foundation

// MARK: - Pokemon
struct Pokemon: Codable {
    let count: Int
    let next: String
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let name: String
    let url: String
}
