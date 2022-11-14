import Foundation

protocol ListPresenter {
    func loadAllPokemonsPages()
    func transitionToDeatailsModule()
}

final class PokemonListPresenter: ListPresenter {
    // MARK: - Constants
    unowned let listView: ListView

    // MARK: - Properties
    // MARK: - Lifecycle
    init(listView: ListView) {
        self.listView = listView
    }

    // MARK: - API
    func loadAllPokemonsPages() {
        APIManager.instance.getPokemonsNextPage { [weak self] results in
            self?.listView.setPokemons(pokemons: results.results)
        }
    }

    func transitionToDeatailsModule() {
        let view = DetailsScreenView()
        let presenter = DetailsScreenPresenter(detailsView: view)
        view.detailsPresenter = presenter
        listView.setTransition(view: view, presenter: presenter)
    }
}
