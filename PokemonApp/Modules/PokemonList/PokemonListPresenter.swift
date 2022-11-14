import UIKit

protocol ListPresenter {
    func loadAllPokemonsPages()
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
}
