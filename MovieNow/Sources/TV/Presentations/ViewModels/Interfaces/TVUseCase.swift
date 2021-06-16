import Foundation

protocol TVUseCase {
    func loadDatas(completion: @escaping ([TVPresenter<TVPresenterType>]) -> Void)
}
