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
    func goToInboundFlights(outboundId: Int)
}

protocol InboundRouterProtocol {
    func goToInboundFlights(outboundId: Int)
}

protocol InboundInteractorProtocol {
    var outboundId: Int? { get set }
    func getFlights() -> Single<(inbound: [FlightModel], outbound: [FlightModel])>
    func getAirlines() -> Single<[AirlineEntity]>
}

protocol InboundPresenterProtocol {
    var outbound: [InboundViewControllerListElements] { get }
    var inbound: [InboundViewControllerListElements] { get }

    func viewDidload()
    func goToInboundFlights(outboundId: Int)
}

