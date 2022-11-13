import UIKit

// MARK: - Pokemon
struct Result: Codable {
    let results: [Pokemon]
}

// MARK: - Result
struct Pokemon: Codable {
    let name: String
}
