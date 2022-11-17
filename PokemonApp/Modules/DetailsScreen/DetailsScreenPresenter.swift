import UIKit

protocol DetailsPresenter: ActivityIndicatorPresenter {
    func loadPokemonDetails()
    func startActivityIndicator()
    func stopActivityIndicator()
    func getPokemonsFromUserDefaults()
}

final class DetailsScreenPresenter: DetailsPresenter {
    // MARK: - Constants
    unowned let detailsView: DetailsView
    private let pokemonId: Int
    private let networkManager: APIManager
    private let userDefaultsManager: UserDefaultsManager

    // MARK: - Properties
    // MARK: - Lifecycle
    init(
        detailsView: DetailsView,
        pokemonId: Int,
        networkManager: APIManager,
        userDefaultsManager: UserDefaultsManager
    ) {
        self.detailsView = detailsView
        self.pokemonId = pokemonId
        self.networkManager = networkManager
        self.userDefaultsManager = userDefaultsManager
    }

    // MARK: - API
    func loadPokemonDetails() {
        networkManager.getPokemonDetails(pokemonId: pokemonId) { [weak self] result in
            switch result {
            case .success(let pokemon):
                self?.detailsView.setPokemonName(name: pokemon.name)
                self?.detailsView.setPokemonType(types: pokemon.types)
                self?.detailsView.setPokemonHeight(height: pokemon.height)
                self?.detailsView.setPokemonWeight(weight: pokemon.weight)
                self?.userDefaultsManager.savePokemonToUserDefaults(pokemon: pokemon)
                self?.networkManager.loadImage(imageLink: pokemon.sprites.frontDefault ?? "") { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let image):
                            self?.detailsView.setPokemonImage(image: image)
                        case .failure(let error): self?.detailsView.showAlertError(message: error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                self?.detailsView.showAlertError(message: error.localizedDescription)
                self?.getPokemonsFromUserDefaults()
            }
        }
    }

    func startActivityIndicator() { detailsView.startActivityIndicator().indicator.startAnimating() }

    func stopActivityIndicator() {
        detailsView.stopActivityIndicator().indicator.stopAnimating()
        detailsView.stopActivityIndicator().backgroundColor = AppColor.clearColor
        detailsView.stopActivityIndicator().removeFromSuperview()
    }

    func getPokemonsFromUserDefaults() {
        detailsView.setSavedPokemons(savedPokemons: userDefaultsManager.getPokemonsFromUserDefaults())
    }
}
