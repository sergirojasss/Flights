//
//  InboundRouter.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import UIKit

final class InboundRouter {
    weak var view: InboundViewController!
    
    init(withView view: InboundViewController) {
        self.view = view
    }
}

extension InboundRouter: InboundRouterProtocol {
}
