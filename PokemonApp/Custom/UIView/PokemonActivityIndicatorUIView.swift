import UIKit

final class PokemonActivityIndicatorUIView: UIView {
    // MARK: - Init
    let indicator = UIActivityIndicatorView(style: .large)

    init(
        style: UIActivityIndicatorView.Style,
        isAnimating: Bool
    ) {
        super.init(frame: .zero)
        setupColor(color: AppColor.fadingEffect)
        setupActivityIndicator(style: style, activityIndicatorIsActive: isAnimating)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setups
    private func setupColor(color: UIColor) {
        backgroundColor = color
    }

    private func setupActivityIndicator(style: UIActivityIndicatorView.Style, activityIndicatorIsActive: Bool) {
        addSubview(indicator)
        indicator.color = .white
        indicator.style = style
        switch activityIndicatorIsActive {
        case true: indicator.startAnimating()
        case false: indicator.stopAnimating()
        }
    }
}
