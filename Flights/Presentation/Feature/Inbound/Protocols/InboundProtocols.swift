//
//  InboundProtocols.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import RxSwift

protocol InboundViewProtocol {
    func reloadFlights(with model: [FlightModel])
    func showError(_ error: ServiceError)
}

protocol InboundRouterProtocol {
}

protocol InboundInteractorProtocol {
    func getMatchingFlights() -> Single<[FlightModel]>
}

protocol InboundPresenterProtocol {
    func viewDidload()
}
