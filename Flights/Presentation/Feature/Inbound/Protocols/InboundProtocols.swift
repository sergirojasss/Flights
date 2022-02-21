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
    func showTotalPrice(_ totalPrice: String)
    func showEmptyState()
}

protocol InboundRouterProtocol {
}

protocol InboundInteractorProtocol {
    func getMatchingFlights() -> Single<[FlightModel]>
    func getTotalPrice(inboundId: Int) -> Float?
}

protocol InboundPresenterProtocol {
    func viewDidload()
    func showTotalPrice(inboundId: Int)
}
