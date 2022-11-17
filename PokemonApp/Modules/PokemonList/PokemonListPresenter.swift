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
    private let alertManager: AlertManager
    private let userDefaultsManager: UserDefaultsManager

    // MARK: - Properties
    // MARK: - Lifecycle
    init(
        listView: ListView,
        networkManager: APIManager,
        alertManager: AlertManager,
        userDefaultsManager: UserDefaultsManager
    ) {
        self.listView = listView
        self.networkManager = networkManager
        self.alertManager = alertManager
        self.userDefaultsManager = userDefaultsManager
    }

    // MARK: - API
    func loadAllPokemonsPages() {
        networkManager.getPokemonsNextPage { [weak self] result in
            switch result {
            case .success(let models): self?.listView.setPokemons(pokemons: models.results)
            case.failure(let error): self?.listView.showAlertError(message: error.localizedDescription)
            }
        }
    }

    func transitionToDeatailsModule(pokemonId: Int) {
        let view = DetailsScreenView(alertManager: alertManager)
        let presenter = DetailsScreenPresenter(
            detailsView: view,
            pokemonId: pokemonId,
            networkManager: networkManager,
            userDefaultsManager: userDefaultsManager
        )
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
