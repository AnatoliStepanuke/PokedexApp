import Foundation

protocol DetailsPresenter {

}

final class DetailsScreenPresenter: DetailsPresenter {
    // MARK: - Constants
    unowned let detailsView: DetailsView

    // MARK: - Properties
    // MARK: - Lifecycle
    init(detailsView: DetailsView) {
        self.detailsView = detailsView
    }

    // MARK: - API

}
