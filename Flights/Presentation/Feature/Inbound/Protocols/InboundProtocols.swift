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
    /// Returns matching flights for the outbound flight ID. Outbound flight ID is not passed throught parameter because this interactor is initiated with it
    func getMatchingFlights() -> Single<[FlightModel]>
    func getTotalPrice(inboundId: Int) -> Float?
}

protocol InboundPresenterProtocol {
    func viewDidload()
    func showTotalPrice(inboundId: Int)
}
