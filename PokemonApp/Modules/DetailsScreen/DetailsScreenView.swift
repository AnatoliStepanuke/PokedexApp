import UIKit

protocol DetailsView: AnyObject {
    func setPokemonImage(image: UIImage)
    func setPokemonName(name: String)
}

final class DetailsScreenView: UIViewController {
    // MARK: - Constants
    private let pokemonImageView = UIImageView()
    private let pokemonNameLabel = PokemonUILabel(height: 25, fontSize: 21, fontWeight: .semibold, fontColor: .black)
    private let pokemonTypeLabel = PokemonUILabel(height: 25, fontSize: 21, fontWeight: .regular, fontColor: .black)

    // MARK: - Properties
    var detailsPresenter: DetailsPresenter?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPokemonImageView()
        setupPokemonNameLabel()
    }

    override func viewDidAppear(_ animated: Bool) {
        if let detailsPresenter = detailsPresenter {
            detailsPresenter.loadPokemonDetails()
        }
    }

    // MARK: - Setups
    private func setupView() {
        view.backgroundColor = AppColor.shadowColor
        view.addSubviews(views: pokemonImageView, pokemonNameLabel, pokemonTypeLabel)
    }

    private func setupPokemonImageView() {
        pokemonImageView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: nil,
            padding: .init(top: 250, left: 0, bottom: 0, right: 0),
            size: .init(width: 200, height: 200)
        )
        pokemonImageView.contentMode = .scaleAspectFit
    }

    private func setupPokemonNameLabel() {
        pokemonNameLabel.anchor(
            top: pokemonImageView.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: nil,
            padding: .init(top: 36, left: 16, bottom: 0, right: 16)
        )
    }

    private func setupPokemonTypeLabel() {
        pokemonNameLabel.anchor(
            top: pokemonNameLabel.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: nil,
            padding: .init(top: 12, left: 16, bottom: 0, right: 16)
        )
    }
}

extension DetailsScreenView: DetailsView {
    // MARK: - API
    func setPokemonImage(image: UIImage) {
        pokemonImageView.image = image
    }

    func setPokemonName(name: String) {
        pokemonNameLabel.text = "Pokemon name: \(name)"
    }
}
