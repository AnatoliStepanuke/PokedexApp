import UIKit

protocol ListView: AnyObject {
    func setPokemons(pokemons: [Pokemon])
    func setTransition(view: DetailsScreenView, presenter: DetailsScreenPresenter)
}

final class PokemonListView: UIViewController {
    // MARK: - Constants
    // Private
    private let tableView = UITableView()

    // MARK: - Properties
    // Public
    var listPresenter: ListPresenter?
    var pokemons: [Pokemon] = [] {
        didSet { tableView.reloadData() }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationController()
        setupTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let listPresenter = listPresenter {
            listPresenter.loadAllPokemonsPages()
        }
    }

    // MARK: - Setups
    private func setupView() { view.addSubview(tableView) }
    private func setupNavigationController() {
        title = "Pokemon List"
        navigationController?.navigationBar.prefersLargeTitles = true
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
}

extension PokemonListView: ListView {
    // MARK: - API
    func setPokemons(pokemons: [Pokemon]) { self.pokemons += pokemons }
    func setTransition(view: DetailsScreenView, presenter: DetailsScreenPresenter) {
        navigationController?.pushViewController(view, animated: true)
    }
}
