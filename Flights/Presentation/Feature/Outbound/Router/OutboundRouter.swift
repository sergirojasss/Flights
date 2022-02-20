//
//  OutboundRouter.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import UIKit

final class OutboundRouter {
    weak var view: InboundViewController!
    
    init(withView view: InboundViewController) {
        self.view = view
    }
}

extension OutboundRouter: OutboundRouterProtocol {
    func goToInboundFlights(outboundModel: FlightModel, inboundFlights: [FlightModel]) {
        let viewController = InboundServiceLocator.provideViewController(with: outboundModel, flights: inboundFlights)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
}
