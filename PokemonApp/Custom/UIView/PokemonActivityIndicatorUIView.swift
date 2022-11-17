import UIKit

protocol ActivityIndicatorPresenter {
    func startActivityIndicator()
    func stopActivityIndicator()
}

protocol ActivityIndicatorView {
    func startActivityIndicator() -> PokemonActivityIndicatorUIView
    func stopActivityIndicator() -> PokemonActivityIndicatorUIView
}

final class PokemonActivityIndicatorUIView: UIView {
    // MARK: - Constants
    let indicator = UIActivityIndicatorView()

    // MARK: - Init
    init(
        style: UIActivityIndicatorView.Style,
        color: UIColor
    ) {
        super.init(frame: .zero)
        setupBackgroundColor(color: color)
        setupIndicator(style: style)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setups
    private func setupBackgroundColor(color: UIColor) {
        backgroundColor = color
    }

    private func setupIndicator(style: UIActivityIndicatorView.Style) {
        addSubview(indicator)
        indicator.color = .white
        indicator.style = style
    }
}
