//
//  InboundPresenter.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation
import RxSwift

final class InboundPresenter {
    private let disposeBag = DisposeBag()
    
    let router: InboundRouterProtocol
    let interactor: InboundInteractorProtocol
    var view: InboundViewProtocol!
    
    init(withView view: InboundViewProtocol, interactor: InboundInteractorProtocol, router: InboundRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension InboundPresenter: InboundPresenterProtocol {
    
    func viewDidload() {
        interactor.getMatchingFlights()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success(let flightModel):
                    if flightModel.isEmpty {
                        self.view.showEmptyState()
                    } else {
                        self.view.reloadFlights(with: flightModel)
                    }
                default:
                    break
                }
            }
    }
    
    func showTotalPrice(inboundId: Int) {
        if let price = interactor.getTotalPrice(inboundId: inboundId) {
            view.showTotalPrice("\(price) €")
        } else {
            view.showTotalPrice("Error")
        }
    }

}
