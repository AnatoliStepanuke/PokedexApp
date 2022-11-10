import UIKit

final class PokemonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Constants
    private let tableView = UITableView()

    // MARK: - Properties
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    // MARK: - Setups
    private func setupView() {
        view.addSubview(tableView)
    }

    private func setupTableView() {
        tableView.fillEntireView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
        tableView.backgroundColor = AppColor.shadowColor
        tableView.separatorStyle = .none
    }

    // MARK: - UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}
