//
//  InboundInteractor.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation
import RxSwift

protocol InboundInteractorDependenciesProtocol {
    var flightsUseCase: FlightsUseCase { get set }
}

final class DefaultInboundInteractorDependencies: InboundInteractorDependenciesProtocol {
    var flightsUseCase: FlightsUseCase
    
    init(useCase: FlightsUseCase = DefaultFlightsUseCase()) {
        self.flightsUseCase = useCase
    }
}

final class InboundInteractor {
    var dependencies: InboundInteractorDependenciesProtocol
    var outbundFlightId: Int
    
    init(outbundFlightId: Int,
         dependencies: InboundInteractorDependenciesProtocol = DefaultInboundInteractorDependencies()) {
        self.dependencies = dependencies
        self.outbundFlightId = outbundFlightId
    }
}

extension InboundInteractor: InboundInteractorProtocol {
    func getTotalPrice(inboundId: Int) -> Float? {
        dependencies.flightsUseCase.getTotalPrice(outboundId: outbundFlightId, inboundId: inboundId)
    }
    
    func getMatchingFlights() -> Single<[FlightModel]> {
        return .just(dependencies.flightsUseCase.getInboundFlights(for: outbundFlightId).map{FlightModel(from: $0)})
    }
}
