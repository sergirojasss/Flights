//
//  InboundServiceLocator.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation

enum ViewType {
    case inbound
    case outbound
}

final class InboundServiceLocator {
    static func provideViewController() -> InboundViewController {
        let viewController = InboundViewController()
        viewController.viewType = .inbound
        let router = InboundRouter(withView: viewController)

        let interactor = InboundInteractor()
        let presenter = InboundPresenter(withView: viewController, interactor: interactor, router: router)
        
        viewController.presenter = presenter

        return viewController
    }
}

final class OutboundServiceLocator {
    static func provideViewController() -> InboundViewController {
        let viewController = InboundViewController()
        viewController.viewType = .outbound
        let router = InboundRouter(withView: viewController)

        let interactor = InboundInteractor()
        let presenter = InboundPresenter(withView: viewController, interactor: interactor, router: router)
        
        viewController.presenter = presenter

        return viewController
    }
}
