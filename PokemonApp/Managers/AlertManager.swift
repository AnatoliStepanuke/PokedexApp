import UIKit

final class AlertManager {
    // MARK: - Helpers
    private func showAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }

    // MARK: - API
    func showAlertError(message: String) -> UIAlertController {
        let alertError = showAlert(title: "Attention", message: message)
        return alertError
    }
}
