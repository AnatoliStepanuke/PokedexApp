import Foundation

final class UserDefaultsManager {
    // MARK: - Constants
    // MARK: - Private
    private let defaults = UserDefaults.standard

    // MARK: - Helpers
    private func encode(pokemons: [PokemonDetails], key: String) {
        if let encodedData = try? JSONEncoder().encode(pokemons) {
            return defaults.setValue(encodedData, forKey: key)
        }
    }

    private func decode(key: String) -> [PokemonDetails] {
        if let decodedData = defaults.data(forKey: key) {
            let pokemons = try? JSONDecoder().decode([PokemonDetails].self, from: decodedData)
            if let resultPokemons = pokemons {
                return resultPokemons
            }
        }
        return []
    }

    // MARK: - API
    func savePokemonToUserDefaults(pokemon: PokemonDetails) {
        var pokemons = getPokemonsFromUserDefaults()
        pokemons.append(pokemon)
        encode(pokemons: pokemons, key: ConstantsUserDefaults.pokemonDetails)
    }

    func getPokemonsFromUserDefaults() -> [PokemonDetails] {
        decode(key: ConstantsUserDefaults.pokemonDetails)
    }
}
