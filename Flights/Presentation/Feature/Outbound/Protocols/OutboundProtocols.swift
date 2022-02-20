//
//  OutboundProtocols.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import RxSwift

protocol OutboundViewProtocol {
    func reloadFlights()
    func showError(_ error: ServiceError)
    func goToOutboundFlights(outboundId: Int)
}

protocol OutboundRouterProtocol {
    func goToInboundFlights(airlines: [AirlineModel], outboundModel: FlightModel, inboundFlights: [FlightModel])
}

protocol OutboundInteractorProtocol {
    func getFlights() -> Single<(inbound: [FlightModel], outbound: [FlightModel])>
    func getAirlines() -> Single<[AirlineModel]?>
}

protocol OutboundPresenterProtocol {
    var inboundFlightModels: [FlightModel] { get set }
    var outboundFlightModels: [FlightModel] { get set }
    var airlines: [AirlineModel] { get set }

    func viewDidload()
    func goToInboundFlights(outboundModelId: Int)
    func getAirline(for name: String) -> AirlineModel?
}

