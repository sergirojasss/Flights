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
}

extension InboundRouter: InboundRouterProtocol {
    func goToInboundFlights(outboundId: Int) {
        let viewController = InboundServiceLocator.provideViewController()
        viewController.selectedOutBoundId = outboundId
        view.navigationController?.pushViewController(viewController, animated: true)
    }
}
