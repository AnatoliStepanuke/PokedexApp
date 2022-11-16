import UIKit

protocol DetailsPresenter: ActivityIndicatorPresenter {
    func loadPokemonDetails()
    func startActivityIndicator()
    func stopActivityIndicator()
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
        networkManager.getPokemonDetails(pokemonId: pokemonId) { [weak self] result in
            switch result {
            case .success(let pokemon):
                self?.networkManager.loadImage(imageLink: pokemon.sprites.frontDefault ?? "") { [weak self] image in
                    DispatchQueue.main.async {
                        self?.detailsView.setPokemonImage(image: image)
                        self?.detailsView.setPokemonName(name: pokemon.name)
                        self?.detailsView.setPokemonType(types: pokemon.types)
                        self?.detailsView.setPokemonHeight(height: pokemon.height)
                        self?.detailsView.setPokemonWeight(weight: pokemon.weight)
                    }
                }
            case .failure(let error): self?.detailsView.showAlertError(message: error.localizedDescription)
            }
        }
    }

    func startActivityIndicator() { detailsView.startActivityIndicator().indicator.startAnimating() }

    func stopActivityIndicator() {
        detailsView.stopActivityIndicator().indicator.stopAnimating()
        detailsView.stopActivityIndicator().backgroundColor = AppColor.clearColor
        detailsView.stopActivityIndicator().removeFromSuperview()
    }
}
