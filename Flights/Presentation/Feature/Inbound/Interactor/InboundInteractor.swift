//
//  InboundInteractor.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation
import RxSwift

protocol InboundInteractorDependenciesProtocol {
}

final class DefaultInboundInteractorDependencies: InboundInteractorDependenciesProtocol {
}

final class InboundInteractor {
    var dependencies: InboundInteractorDependenciesProtocol
    var outboundModel: FlightModel?
    var inboundFlights: [FlightModel]?
    
    init(outboundModel: FlightModel,
         inboundFlights: [FlightModel],
         dependencies: InboundInteractorDependenciesProtocol = DefaultInboundInteractorDependencies()) {
        self.outboundModel = outboundModel
        self.inboundFlights = inboundFlights
        self.dependencies = dependencies
    }
}

extension InboundInteractor: InboundInteractorProtocol {
    func getMatchingFlights() -> [FlightModel] {
        let matching = outboundModel?.isCombinableWith(transports: inboundFlights ?? [])
        return matching ?? []
    }
}
