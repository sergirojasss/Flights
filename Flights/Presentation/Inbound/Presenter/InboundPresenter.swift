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
    
    var flights: [FlightModel] = [] {
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
                case .success(let flightsListEntity):
                    self.flights = flightsListEntity.map{$0.toModel()}
                case .failure(let error):
                    if let error = error as? ServiceError {
                        self.view.showError(error)
                    }
                    debugPrint("uncontrolled Error")
                }
            }.disposed(by: disposeBag)
        
    }
}
