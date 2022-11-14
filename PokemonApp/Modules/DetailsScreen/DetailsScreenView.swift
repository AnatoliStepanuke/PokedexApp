import UIKit

protocol DetailsView: AnyObject {
    func setPokemonImage(image: UIImage)
}

final class DetailsScreenView: UIViewController {
    // MARK: - Constants
    private let pokemonImage = UIImageView()

    // MARK: - Properties
    var detailsPresenter: DetailsPresenter?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPokemonImage()
    }

    override func viewDidAppear(_ animated: Bool) {
        if let detailsPresenter = detailsPresenter {
            detailsPresenter.loadPokemonImage()
        }
    }

    // MARK: - Setups
    private func setupView() {
        view.backgroundColor = AppColor.shadowColor
        view.addSubview(pokemonImage)
    }

    private func setupPokemonImage() {
        pokemonImage.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor
        )
        pokemonImage.contentMode = .scaleAspectFit
    }
}

extension DetailsScreenView: DetailsView {
    // MARK: - API
    func setPokemonImage(image: UIImage) {
        pokemonImage.image = image
    }
}
