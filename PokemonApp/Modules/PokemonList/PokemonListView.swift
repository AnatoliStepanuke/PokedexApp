import UIKit

protocol ListView: AnyObject {
    func setPokemons(pokemons: [Pokemon])
}

final class PokemonListView: UIViewController, ListView {
    // MARK: - Constants
    // Private
    private let tableView = UITableView()

    // MARK: - Properties
    // Public
    var listPresenter: ListPresenter?

    // Private
    private var pokemons: [Pokemon] = [] {
        didSet { tableView.reloadData() }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let pokemonListPresenterProtocol = listPresenter {
            pokemonListPresenterProtocol.loadAllPokemons()
        }
    }

    // MARK: - API
    func setPokemons(pokemons: [Pokemon]) { self.pokemons = pokemons }

    // MARK: - Setups
    private func setupView() { view.addSubview(tableView) }
    private func setupTableView() {
        tableView.fillEntireView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(PokemonCell.self, forCellReuseIdentifier: "PokemonCell")
        tableView.backgroundColor = .white
    }
}

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
