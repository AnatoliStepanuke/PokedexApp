import UIKit

final class PokemonUIImageView: UIImageView {
    // MARK: - Init
    init(
        imageName: String,
        contentMode: UIView.ContentMode
    ) {
        super.init(frame: .zero)
        setupImage(systemName: imageName, contentMode: contentMode, color: AppColor.blackColor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setups
    private func setupImage(systemName: String, contentMode mode: UIView.ContentMode, color: UIColor) {
        image = UIImage(systemName: systemName)
        contentMode = mode
        tintColor = color
    }
}
