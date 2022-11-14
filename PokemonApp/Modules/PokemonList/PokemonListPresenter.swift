import UIKit

protocol ListPresenter {
    func loadAllPokemons()
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
    func loadAllPokemons() {
        APIManager.getResults { [weak self] results in
            self?.listView.setPokemons(pokemons: results.results)
        }
    }
}
