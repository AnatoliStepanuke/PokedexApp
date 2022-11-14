import UIKit

extension PokemonListView: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PokemonCell",
            for: indexPath
        ) as? PokemonCell else { fatalError("DequeueReusableCell failed while casting.") }
        let pokemon = pokemons[indexPath.row]
        cell.configure(using: pokemon, paginationCount: indexPath)
        cell.backgroundColor = .white
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}