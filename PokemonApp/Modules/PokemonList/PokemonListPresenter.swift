import Foundation

protocol ListPresenter {
    func loadAllPokemonsPages()
    func transitionToDeatailsModule(pokemonId: Int)
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

    func transitionToDeatailsModule(pokemonId: Int) {
        let view = DetailsScreenView()
        let presenter = DetailsScreenPresenter(detailsView: view, pokemonId: pokemonId)
        view.detailsPresenter = presenter
        listView.setTransition(view: view, presenter: presenter)
    }
}
