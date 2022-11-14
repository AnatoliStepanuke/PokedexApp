import UIKit

extension UIStackView {
    func addArrangedSubviews(_ arrangedSubviews: [UIView]) {
        for arrangedSubview in arrangedSubviews {
            addArrangedSubview(arrangedSubview)
        }
    }
}
