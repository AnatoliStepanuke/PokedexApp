import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Properties
    var window: UIWindow?

    // MARK: - Constants
    private let navigationController = UINavigationController()
    private let rootViewController = PokemonListView()
    private let networkManager = APIManager()

    // MARK: - UIScene
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let view = rootViewController
        let presenter = PokemonListPresenter(listView: view, networkManager: networkManager)
        view.listPresenter = presenter
        navigationController.pushViewController(view, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
