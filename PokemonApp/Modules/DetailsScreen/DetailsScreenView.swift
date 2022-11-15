import UIKit

protocol DetailsView: AnyObject {
    func setPokemonImage(image: UIImage)
    func setPokemonName(name: String)
    func setPokemonType(types: [TypeElement])
    func setPokemonHeight(height: Int)
    func setPokemonWeight(weight: Int)
}

final class DetailsScreenView: UIViewController {
    // MARK: - Constants
    private let pokemonImageView = PokemonUIImageView(
        imageName: "person.circle",
        contentMode: .scaleAspectFit
    )
    private let pokemonStackView = PokemonUIStackView(
        axis: .vertical,
        alignment: .leading,
        distribution: .equalSpacing,
        height: 125
    )
    private let pokemonNameLabel = PokemonUILabel(
        text: "Pokemon name: -",
        height: 25,
        fontSize: 21,
        fontWeight: .medium,
        fontColor: AppColor.blackColor
    )
    private let pokemonTypeLabel = PokemonUILabel(
        text: "Type: -",
        height: 25,
        fontSize: 21,
        fontWeight: .regular,
        fontColor: AppColor.blackColor
    )
    private let pokemonHeightLabel = PokemonUILabel(
        text: "Height: - cm",
        height: 25,
        fontSize: 17,
        fontWeight: .light,
        fontColor: AppColor.blackColor
    )
    private let pokemonWeightLabel = PokemonUILabel(
        text: "Weight: - kg",
        height: 25,
        fontSize: 17,
        fontWeight: .light,
        fontColor: AppColor.blackColor
    )

    // MARK: - Properties
    var detailsPresenter: DetailsPresenter?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPokemonImageView()
        setupPokemonUIStackView()
    }

    override func viewDidAppear(_ animated: Bool) {
        if let detailsPresenter = detailsPresenter { detailsPresenter.loadPokemonDetails() }
    }

    // MARK: - Setups
    private func setupView() {
        view.backgroundColor = AppColor.shadowColor
        view.addSubviews(pokemonImageView, pokemonStackView)
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
    }

    private func setupPokemonUIStackView() {
        pokemonStackView.anchor(
            top: pokemonImageView.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: nil,
            padding: .init(top: 36, left: 16, bottom: 0, right: 16)
        )
        pokemonStackView.addArrangedSubviews([
            pokemonNameLabel,
            pokemonTypeLabel,
            pokemonHeightLabel,
            pokemonWeightLabel
        ])
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

    func setPokemonType(types: [TypeElement]) {
        for type in types { pokemonTypeLabel.text = "Type: \(type.type.name)" }
    }

    func setPokemonHeight(height: Int) {
        pokemonHeightLabel.text = "Height: \(height * 100) cm"
    }

    func setPokemonWeight(weight: Int) {
        pokemonWeightLabel.text = "Weight: \(weight / 10) kg"
    }
}
