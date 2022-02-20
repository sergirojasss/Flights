//
//  InboundPresenter.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation
import RxSwift

final class InboundPresenter {
    let router: InboundRouterProtocol
    let interactor: InboundInteractorProtocol
    var view: InboundViewProtocol!
    
    private let disposeBag = DisposeBag()
    
    var inbound: [FlightModel] = [] {
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
        inbound = interactor.getMatchingFlights()
    }
}
