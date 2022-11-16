import Foundation

// MARK: - Pokemon Details
struct PokemonDetails: Codable {
    let height: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int
}

// MARK: - Sprites
struct Sprites: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_defaultz"
    }
}

// MARK: - Types
struct TypeElement: Codable {
    let type: Species
}

// MARK: - Species
struct Species: Codable {
    let name: String
}
