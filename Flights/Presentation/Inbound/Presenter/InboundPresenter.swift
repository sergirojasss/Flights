//
//  InboundPresenter.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation

final class InboundPresenter {
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
    
}
