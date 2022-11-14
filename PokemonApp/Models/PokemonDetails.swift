import Foundation

// MARK: - Pokemon Details
struct PokemonDetails: Codable {
    let name: String
    let sprites: Sprites
}

struct Sprites: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
