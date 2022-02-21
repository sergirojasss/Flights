//
//  InboundServiceLocator.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation

final class InboundServiceLocator {
    static func provideViewController(outbundFlightId: Int,
                                      useCase: FlightsUseCase) -> InboundViewController {
        let viewController = InboundViewController()
        viewController.viewType = .inbound
        let router = InboundRouter(withView: viewController)

        let interactor = InboundInteractor(outbundFlightId: outbundFlightId,
                                           dependencies: DefaultInboundInteractorDependencies(useCase: useCase))
        let presenter = InboundPresenter(withView: viewController, interactor: interactor, router: router)
        
        viewController.inboundPresenter = presenter

        return viewController
    }
}
