import UIKit

protocol DetailsView: AnyObject {

}

final class DetailsScreenView: UIViewController {
    // MARK: - Constants
    // MARK: - Properties
    var detailsPresenter: DetailsPresenter?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.shadowColor
    }

    // MARK: - Setups
}

extension DetailsScreenView: DetailsView {

}
