//
//  InboundRouter.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import UIKit

final class InboundRouter {
    weak var view: InboundViewController!
    
    init(withView view: InboundViewController) {
        self.view = view
    }
    
    static func assembleModule(viewController: InboundViewController = InboundViewController(), withinNavController: Bool = false) -> UIViewController {
        let router = InboundRouter(withView: viewController)
        
        let interactor = InboundInteractor()
        let presenter = InboundPresenter(withView: viewController, interactor: interactor, router: router)
        
        viewController.presenter = presenter
        
        if withinNavController {
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.isNavigationBarHidden = true
            return navigationController
        }
        
        return viewController
    }
}

extension InboundRouter: InboundRouterProtocol {
    
}
