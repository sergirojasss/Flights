//
//  OutboundRouter.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import UIKit

final class OutboundRouter {
    weak var view: OutboundViewController!
    
    init(withView view: OutboundViewController) {
        self.view = view
    }
    
    static func assembleModule(viewController: OutboundViewController = OutboundViewController(), withinNavController: Bool = false) -> UIViewController {
        let router = OutboundRouter(withView: viewController)
        
        let interactor = OutboundInteractor()
        let presenter = OutboundPresenter(withView: viewController, interactor: interactor, router: router)
        
        viewController.presenter = presenter
        
        if withinNavController {
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.isNavigationBarHidden = true
            return navigationController
        }
        
        return viewController
    }
}

extension OutboundRouter: OutboundRouterProtocol {
    
}
