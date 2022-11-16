import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Properties
    var window: UIWindow?

    // MARK: - Constants
    private let navigationController = UINavigationController()
    private let networkManager = APIManager()
    private let alertManager = AlertManager()
    private let userDefaultsManager = UserDefaultsManager()

    // MARK: - UIScene
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let view = PokemonListView(alertManager: alertManager)
        let presenter = PokemonListPresenter(
            listView: view,
            networkManager: networkManager,
            alertManager: alertManager,
            userDefaultsManager: userDefaultsManager
        )
        view.listPresenter = presenter
        navigationController.pushViewController(view, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
