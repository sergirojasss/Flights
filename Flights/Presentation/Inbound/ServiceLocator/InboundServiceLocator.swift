//
//  InboundServiceLocator.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation

final class InboundServiceLocator {
    static func provideViewController() -> InboundViewController {
        let viewController = InboundViewController()
        let router = InboundRouter(withView: viewController)

        let interactor = InboundInteractor()
        let presenter = InboundPresenter(withView: viewController, interactor: interactor, router: router)
        
        viewController.presenter = presenter

        return viewController
    }
}
