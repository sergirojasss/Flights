//
//  InboundInteractor.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import RxSwift

protocol InboundInteractorDependenciesProtocol {
    var flightsUseCase: FlightsUseCase { get set }
    var airlinesUseCase: AirlinesUseCase { get set }
}

final class DefaultInboundInteractorDependencies: InboundInteractorDependenciesProtocol {
    lazy var flightsUseCase: FlightsUseCase = DefaultFlightsUseCase()
    lazy var airlinesUseCase: AirlinesUseCase = DefaultAirlinesUseCase()
}

final class InboundInteractor {
    var dependencies: InboundInteractorDependenciesProtocol
    
    init(dependencies: InboundInteractorDependenciesProtocol = DefaultInboundInteractorDependencies()) {
        self.dependencies = dependencies
    }
}

extension InboundInteractor: InboundInteractorProtocol {
    func getFlights() -> Single<(inbound: [FlightModel], outbound: [FlightModel])> {
        dependencies.flightsUseCase.execute(orderBy: .asc).map { result -> (inbound: [FlightModel], outbound: [FlightModel]) in
            var inbound: [FlightModel] = []
            var outbound: [FlightModel] = []
            for flight in result {
                flight.type == .inbound ? inbound.append(flight.toModel()) : outbound.append(flight.toModel())
            }
            return (inbound, outbound)
        }
    }
    func getAirlines() -> Single<[AirlineEntity]> {
        dependencies.airlinesUseCase.execute()
    }
}
