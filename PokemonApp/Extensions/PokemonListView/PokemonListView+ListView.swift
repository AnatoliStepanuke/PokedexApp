import Foundation

extension PokemonListView: ListView {
    func setPokemons(pokemons: [Pokemon]) { self.pokemons += pokemons }
    func setTransition(view: DetailsScreenView, presenter: DetailsScreenPresenter) {
        navigationController?.pushViewController(view, animated: true)
    }
}
