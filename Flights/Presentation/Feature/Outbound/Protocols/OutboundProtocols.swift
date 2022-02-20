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
    func goToInboundFlights(outboundModel: FlightModel, inboundFlights: [FlightModel])
}

protocol OutboundInteractorProtocol {
    func getFlights() -> Single<(inbound: [FlightModel], outbound: [FlightModel])>
    func getAirlines() -> Single<[AirlineEntity]>
}

protocol OutboundPresenterProtocol {
    var outbound: [CellTypes] { get }
    var inbound: [CellTypes] { get }

    func viewDidload()
    func goToInboundFlights(outboundModelId: Int)
}

