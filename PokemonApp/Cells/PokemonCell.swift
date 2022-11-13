import UIKit

final class PokemonCell: UITableViewCell {
    // MARK: - Constants
    private let pokemonLabel = PokemonUILabel(height: 25, fontSize: 21, fontColor: .black)

    // MARK: - Variables
    var paginationLabel = PokemonUILabel(height: 25, fontSize: 17, fontColor: .black)

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContainerView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setups
    private func setupContainerView() {
        self.addSubview(pokemonLabel)
        self.addSubview(paginationLabel)
        pokemonLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: paginationLabel.leadingAnchor,
            bottom: nil,
            padding: .init(top: 4, left: 16, bottom: 0, right: 4)
        )
        paginationLabel.anchor(
            top: topAnchor,
            leading: pokemonLabel.trailingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 4, left: 4, bottom: 0, right: 16)
        )
    }

    // MARK: - API
    func configure(using pokemon: Pokemon, paginationCount: IndexPath) {
        pokemonLabel.text = pokemon.name
        paginationLabel.text = "\(paginationCount.row + 1)"
    }
}
