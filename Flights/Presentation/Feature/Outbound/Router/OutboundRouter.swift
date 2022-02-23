//
//  OutboundRouter.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import UIKit

final class OutboundRouter {
    weak var view: InOutCommonViewController!
    
    init(withView view: InOutCommonViewController) {
        self.view = view
    }
}

extension OutboundRouter: OutboundRouterProtocol {
    func goToInboundFlights(for outbundFlightId: Int, useCase: FlightsUseCase) {
        let viewController = InboundServiceLocator.provideViewController(outbundFlightId: outbundFlightId, useCase: useCase)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
}
