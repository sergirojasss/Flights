//
//  InboundProtocols.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import RxSwift

protocol InboundViewProtocol {
    func reloadFlights()
    func showError(_ error: ServiceError)
}

protocol InboundRouterProtocol {
}

protocol InboundInteractorProtocol {
    var airlines: [AirlineModel]? { get }
    var outboundModel: FlightModel? { get set }
    func getMatchingFlights() -> [FlightModel]
}

protocol InboundPresenterProtocol {
    var inbound: [FlightModel] { get }

    func viewDidload()
    func getAirline(for name: String) -> AirlineModel?
}
