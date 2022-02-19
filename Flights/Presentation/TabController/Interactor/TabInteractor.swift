//
//  TabInteractor.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import RxSwift

protocol TabInteractorDependenciesProtocol {
    var flightsUseCase: FlightsUseCase { get }
    var airlinesUseCase: AirlinesUseCase { get }
}

final class DefaultTabInteractorDependencies: TabInteractorDependenciesProtocol {
    lazy var flightsUseCase: FlightsUseCase = DefaultFlightsUseCase()
    lazy var airlinesUseCase: AirlinesUseCase = DefaultAirlinesUseCase()
    
//    init(flightsUseCase: FlightsUseCase = DefaultFlightsUseCase(),
//         airlinesUseCase: AirlinesUseCase = DefaultAirlinesUseCase()) {
//        self.flightsUseCase = flightsUseCase
//        self.airlinesUseCase = airlinesUseCase
//    }
}

final class TabInteractor {
    let dependencies: TabInteractorDependenciesProtocol
    
    init(dependencies: TabInteractorDependenciesProtocol = DefaultTabInteractorDependencies()) {
        self.dependencies = dependencies
    }
}

extension TabInteractor: TabInteractorProtocol {
    func loadFlightsAndAirports() -> Single<([Flight], [Airline])> {
        return Single.zip(dependencies.flightsUseCase.execute(), dependencies.airlinesUseCase.execute())

    }
    
    func saveAirlines() {
        //TODO: Save Airlines to realm
    }
    
    func saveFlights() {
        //TODO: Save Flights to realm
    }

}
