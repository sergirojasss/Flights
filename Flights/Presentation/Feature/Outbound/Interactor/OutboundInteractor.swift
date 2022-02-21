//
//  OutboundInteractor.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import RxSwift

protocol OutboundInteractorDependenciesProtocol {
    var flightsUseCase: FlightsUseCase { get set }
}

final class DefaultOutboundInteractorDependencies: OutboundInteractorDependenciesProtocol {
    lazy var flightsUseCase: FlightsUseCase = DefaultFlightsUseCase()
}

final class OutboundInteractor {
    private let disposeBag = DisposeBag()
    var dependencies: OutboundInteractorDependenciesProtocol
    
    init(dependencies: OutboundInteractorDependenciesProtocol = DefaultOutboundInteractorDependencies()) {
        self.dependencies = dependencies
    }
}

extension OutboundInteractor: OutboundInteractorProtocol {    
    func loadFlightsWithLogo() -> Single<[FlightModel]> {
        dependencies.flightsUseCase.loadAllInfo()
            .observe(on: MainScheduler.instance)
            .map { (model: ([FlightEntityWithLogo])) -> [FlightModel] in
                var models = [FlightModel]()
                for flight in model {
                    models.append(FlightModel(from: flight))
                }
                return models
            }
    }
}
