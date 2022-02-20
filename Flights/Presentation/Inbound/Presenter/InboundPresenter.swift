//
//  InboundPresenter.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import RxSwift

final class InboundPresenter {
    let router: InboundRouterProtocol
    let interactor: InboundInteractorProtocol
    var view: InboundViewProtocol!
    
    private let disposeBag = DisposeBag()
    
    var outbound: [InboundViewControllerListElements] = [] {
        didSet {
            view.reloadFlights()
        }
    }
    var inbound: [InboundViewControllerListElements] = [] {
        didSet {
            view.reloadFlights()
        }
    }

    
    init(withView view: InboundViewProtocol, interactor: InboundInteractorProtocol, router: InboundRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension InboundPresenter: InboundPresenterProtocol {
    func viewDidload() {
        interactor.getFlights()
            .observe(on: MainScheduler.instance)
            .subscribe{ event in
                switch event {
                case .success(let model):
                    self.inbound = model.inbound.map{InboundViewControllerListElements.flightCell(model: FlightCellModel(from: $0))}
                    self.outbound = model.outbound.map{InboundViewControllerListElements.flightCell(model: FlightCellModel(from: $0))}
                case .failure(let error):
                    if let error = error as? ServiceError {
                        self.view.showError(error)
                    }
                    debugPrint("uncontrolled Error")
                }
            }.disposed(by: disposeBag)
    }
    
    func goToInboundFlights(outboundId: Int) {
        router.goToInboundFlights(outboundId: outboundId)
    }
}
