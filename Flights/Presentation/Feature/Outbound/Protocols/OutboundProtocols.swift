//
//  OutboundProtocols.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import RxSwift

protocol OutboundViewProtocol {
    func reloadFlights(with model: [FlightModel])
    func showError(_ error: ServiceError)
    func goToOutboundFlights(outboundId: Int)
}

protocol OutboundRouterProtocol {
    func goToInboundFlights(for outbundFlight: Int, useCase: FlightsUseCase)
}

protocol OutboundInteractorProtocol {
    /// contains the UseCase wich is passed to Inbound screen.
    /// It's who is storing on session data.
    var dependencies: OutboundInteractorDependenciesProtocol { get }
    
    /// Returns the outbound flights, mapping it to the model
    func getOutboundFlights() -> Single<[FlightModel]>
}

protocol OutboundPresenterProtocol {
    func viewDidload()
    func goToInboundFlights(outboundModelId: Int)
}

