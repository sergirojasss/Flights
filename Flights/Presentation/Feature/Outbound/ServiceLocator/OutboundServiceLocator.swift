//
//  OutboundServiceLocator.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation

final class OutboundServiceLocator {
    static func provideViewController() -> InboundViewController {
        let viewController = InboundViewController()
        viewController.viewType = .outbound
        let router = OutboundRouter(withView: viewController)

        let interactor = OutboundInteractor()
        let presenter = OutboundPresenter(withView: viewController, interactor: interactor, router: router)
        
        viewController.presenter = presenter

        return viewController
    }
}
