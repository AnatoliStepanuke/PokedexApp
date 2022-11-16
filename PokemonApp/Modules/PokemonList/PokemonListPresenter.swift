import Foundation

protocol ListPresenter: ActivityIndicatorPresenter {
    func loadAllPokemonsPages()
    func transitionToDeatailsModule(pokemonId: Int)
    func startActivityIndicator()
    func stopActivityIndicator()
}

final class PokemonListPresenter: ListPresenter {
    // MARK: - Constants
    unowned let listView: ListView
    private let networkManager: APIManager

    // MARK: - Properties
    // MARK: - Lifecycle
    init(listView: ListView, networkManager: APIManager) {
        self.listView = listView
        self.networkManager = networkManager
    }

    // MARK: - API
    func loadAllPokemonsPages() {
        networkManager.getPokemonsNextPage { [weak self] results in
            self?.listView.setPokemons(pokemons: results.results)
        }
    }

    func transitionToDeatailsModule(pokemonId: Int) {
        let view = DetailsScreenView()
        let presenter = DetailsScreenPresenter(detailsView: view, pokemonId: pokemonId, networkManager: networkManager)
        view.detailsPresenter = presenter
        listView.setTransition(view: view, presenter: presenter)
    }

    func startActivityIndicator() { listView.startActivityIndicator().indicator.startAnimating() }

    func stopActivityIndicator() {
        listView.stopActivityIndicator().indicator.stopAnimating()
        listView.stopActivityIndicator().backgroundColor = AppColor.clearColor
        listView.stopActivityIndicator().removeFromSuperview()
    }
}
