//
//  InboundProtocols.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import RxSwift

protocol InboundViewProtocol {
    func reloadFlights()
    func showError(_ error: ServiceError)
}

protocol InboundRouterProtocol {
    
}

protocol InboundInteractorProtocol {
    func getFlights() -> Single<[FlightEntity]>
    func getAirlines() -> Single<[AirlineEntity]>
}

protocol InboundPresenterProtocol {
    func viewDidload()
    var flights: [FlightModel] { get }
}

