//
//  FlightsUseCase.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import RxSwift

enum orderFlightsPrice {
    case asc, desc
}

protocol FlightsUseCase {
    func execute(orderBy: orderFlightsPrice) -> Single<[FlightEntity]>
}

final class DefaultFlightsUseCase: FlightsUseCase {
    
    private let flightsListRepo: FlightsRepository
    
    init(flightsListRepo: FlightsRepository = DefaultFlightsRepository()) {
        self.flightsListRepo = flightsListRepo
    }
    
    func execute(orderBy: orderFlightsPrice) -> Single<[FlightEntity]> {
        flightsListRepo.flightsList().map{ $0.sorted { lhs, rhs in
            orderBy == .asc ? lhs.price > rhs.price : lhs.price < rhs.price
        } }
    }
}

