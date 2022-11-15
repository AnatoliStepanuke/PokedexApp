import UIKit

protocol DetailsPresenter {
    func loadPokemonDetails()
}

final class DetailsScreenPresenter: DetailsPresenter {
    // MARK: - Constants
    unowned let detailsView: DetailsView
    private let pokemonId: Int

    // MARK: - Properties
    // MARK: - Lifecycle
    init(detailsView: DetailsView, pokemonId: Int) {
        self.detailsView = detailsView
        self.pokemonId = pokemonId
    }

    // MARK: - API
    func loadPokemonDetails() {
        APIManager.instance.getPokemonDetails(pokemonId: pokemonId) { [weak self] pokemon in
            APIManager.instance.loadImage(imageLink: pokemon.sprites.frontDefault ?? "") { [weak self] image in
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
