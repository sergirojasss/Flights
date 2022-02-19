//
//  TabRouter.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import UIKit

final class TabRouter {
    weak var view: TabViewController!
    
    init(withView view: TabViewController) {
        self.view = view
    }
    
    static func assembleModule(viewController: TabViewController = TabViewController(), withinNavController: Bool = false) -> UIViewController {
        let router = TabRouter(withView: viewController)
        
        let interactor = TabInteractor()
        let presenter = TabPresenter(withView: viewController, interactor: interactor, router: router)
        
        viewController.presenter = presenter
        
        if withinNavController {
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.isNavigationBarHidden = true
            return navigationController
        }
        
        return viewController
    }
}

extension TabRouter: TabRouterProtocol {
    
}
