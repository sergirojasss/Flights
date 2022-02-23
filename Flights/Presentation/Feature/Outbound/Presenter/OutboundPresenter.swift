//
//  OutboundPresenter.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import RxSwift

final class OutboundPresenter {
    let router: OutboundRouterProtocol
    let interactor: OutboundInteractorProtocol
    var view: OutboundViewProtocol!
    
    private let disposeBag = DisposeBag()
    
    init(withView view: OutboundViewProtocol, interactor: OutboundInteractorProtocol, router: OutboundRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension OutboundPresenter: OutboundPresenterProtocol {
    func viewDidload() {
        interactor.getOutboundFlights()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success(let model):
                    if model.isEmpty {
                        self.view.showEmptyStateAndReload()
                    } else {
                        self.view.reloadFlights(with: model)
                    }
                case .failure(let error):
                    if let _ = error as? ServiceError {
                            guard let error = error as? ServiceError else { return }
                            self.view.showError(error)
                    } else {
                        debugPrint("uncontrolled Error")
                    }
                }
            }
            .disposed(by: disposeBag)
    }
        

    func goToInboundFlights(outboundModelId: Int) {
        router.goToInboundFlights(for: outboundModelId,
                                     useCase: interactor.dependencies.flightsUseCase)
    }
}
