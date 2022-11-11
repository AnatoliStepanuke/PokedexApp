import UIKit

final class PokemonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Constants
    private let tableView = UITableView()

    // MARK: - Properties
    private var pokemons: [Result] = [] {
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
        APIManager.getAllPokemons { pokemon in
            self.pokemons = pokemon.results
        }
    }

    // MARK: - Setups
    private func setupView() {
        view.addSubview(tableView)
    }

    private func setupTableView() {
        tableView.fillEntireView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(PokemonCell.self, forCellReuseIdentifier: "PokemonCell")
        tableView.backgroundColor = .white
    }

    // MARK: - UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
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
}
