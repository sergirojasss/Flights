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
    func getFlights() -> Single<[FlightEntity]> {
        dependencies.flightsUseCase.execute(orderBy: .asc)
    }
    func getAirlines() -> Single<[AirlineEntity]> {
        dependencies.airlinesUseCase.execute()
    }
}
