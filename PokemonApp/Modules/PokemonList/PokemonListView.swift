import UIKit

protocol ListView: AnyObject, ActivityIndicatorView {
    func setPokemons(pokemons: [Pokemon])
    func setTransition(view: DetailsScreenView, presenter: DetailsScreenPresenter)
    func startActivityIndicator() -> PokemonActivityIndicatorUIView
    func stopActivityIndicator() -> PokemonActivityIndicatorUIView
}

final class PokemonListView: UIViewController {
    // MARK: - Constants
    // Private
    private let tableView = UITableView()
    private let activityIndicatorView = PokemonActivityIndicatorUIView(style: .large, color: AppColor.fadingEffect)

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
        setupActivityIndicatorView()
        setupTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let listPresenter = listPresenter {
            listPresenter.loadAllPokemonsPages()
            listPresenter.stopActivityIndicator()
        }
    }

    // MARK: - Setups
    private func setupView() { view.addSubviews(tableView, activityIndicatorView) }

    private func setupNavigationController() {
        title = "Pokemon List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupActivityIndicatorView() {
        activityIndicatorView.fillEntireView()
        activityIndicatorView.indicator.anchor(
            top: activityIndicatorView.topAnchor,
            leading: activityIndicatorView.leadingAnchor,
            trailing: activityIndicatorView.trailingAnchor,
            bottom: activityIndicatorView.bottomAnchor
        )
        if let listPresenter = listPresenter {
            listPresenter.startActivityIndicator()
        }
    }

    private func setupTableView() {
        tableView.fillEntireView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(PokemonCell.self, forCellReuseIdentifier: "PokemonCell")
        tableView.backgroundColor = AppColor.shadowColor
    }
}

extension PokemonListView: ListView {
    // MARK: - API
    func setPokemons(pokemons: [Pokemon]) { self.pokemons += pokemons }

    func setTransition(view: DetailsScreenView, presenter: DetailsScreenPresenter) {
        navigationController?.pushViewController(view, animated: true)
    }

    func startActivityIndicator() -> PokemonActivityIndicatorUIView { return activityIndicatorView }

    func stopActivityIndicator() -> PokemonActivityIndicatorUIView { return activityIndicatorView }
}
