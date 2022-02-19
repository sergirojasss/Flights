//
//  OutboundPresenter.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation

final class OutboundPresenter {
    let router: OutboundRouterProtocol
    let interactor: OutboundInteractorProtocol
    var view: OutboundViewProtocol!

    init(withView view: OutboundViewProtocol, interactor: OutboundInteractorProtocol, router: OutboundRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension OutboundPresenter: OutboundPresenterProtocol {
    
}
