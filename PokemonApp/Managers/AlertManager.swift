import UIKit

final class AlertManager {
    // MARK: - Constants
    // MARK: Public
    static let instance = AlertManager()

    // MARK: - Properties
    // MARK: Public
    var serviceGranted: Bool?

    // MARK: - Init
    private init() { }

    // MARK: - Helpers
    private func showAlert(title: String, message: String) -> UIAlertController {
        serviceGranted = true
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }

    // MARK: - API
    func showAlertError(error: Error?) -> UIAlertController {
        let alertError = showAlert(title: "Error", message: error?.localizedDescription ?? "Firebase error")
        return alertError
    }
}
