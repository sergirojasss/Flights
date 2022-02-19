//
//  TabPresenter.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import RxSwift

final class TabPresenter {
    let router: TabRouterProtocol
    let interactor: TabInteractorProtocol
    var view: TabViewProtocol!

    private let disposeBag: DisposeBag = DisposeBag()

    init(withView view: TabViewProtocol, interactor: TabInteractorProtocol, router: TabRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension TabPresenter: TabPresenterProtocol {
    func viewDidLoad() {
        interactor.loadFlightsAndAirports()
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success(let airlines, let flights):
                    self.interactor.saveAirlines()
                    self.interactor.saveFlights()
                case .failure(let error):
                    switch error {
                    case ServiceError.responseError:
                        //TODO: Try to load from realm
                        break
                    case ServiceError.mappingError:
                        //TODO: Something changed on service Response
                        break
                    default:
                        break
                    }
                }
            }.disposed(by: disposeBag)

    }
}
