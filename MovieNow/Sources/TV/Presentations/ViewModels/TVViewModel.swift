import Foundation

struct TVViewModel {
    private let useCase: TVUseCase

    var onSuccess: (([TVPresenter<TVPresenterType>]) -> Void) = { _ in }

    init(_ useCase: TVUseCase) {
        self.useCase = useCase
    }

    func fetch() {
        useCase.loadDatas { presenters in
            self.onSuccess(presenters)
        }
    }
}
