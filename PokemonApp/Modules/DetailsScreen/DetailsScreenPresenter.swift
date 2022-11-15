import UIKit

protocol DetailsPresenter {
    func loadPokemonDetails()
}

final class DetailsScreenPresenter: DetailsPresenter {
    // MARK: - Constants
    unowned let detailsView: DetailsView
    private let pokemonId: Int
    private let networkManager: APIManager

    // MARK: - Properties
    // MARK: - Lifecycle
    init(detailsView: DetailsView, pokemonId: Int, networkManager: APIManager) {
        self.detailsView = detailsView
        self.pokemonId = pokemonId
        self.networkManager = networkManager
    }

    // MARK: - API
    func loadPokemonDetails() {
        networkManager.getPokemonDetails(pokemonId: pokemonId) { [weak self] pokemon in
            self?.networkManager.loadImage(imageLink: pokemon.sprites.frontDefault ?? "") { [weak self] image in
                DispatchQueue.main.async {
                    self?.detailsView.setPokemonImage(image: image)
                    self?.detailsView.setPokemonName(name: pokemon.name)
                    self?.detailsView.setPokemonType(types: pokemon.types)
                    self?.detailsView.setPokemonHeight(height: pokemon.height)
                    self?.detailsView.setPokemonWeight(weight: pokemon.weight)
                }
            }
        }
    }
}
