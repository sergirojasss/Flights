//
//  FlightsUseCase.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import RxSwift

protocol FlightsUseCase {
    func execute() -> Single<[Flight]>
}

final class DefaultFlightsUseCase: FlightsUseCase {
    
    private let flightsListRepo: FlightsRepository
    
    init(flightsListRepo: FlightsRepository = DefaultFlightsRepository()) {
        self.flightsListRepo = flightsListRepo
    }
    
    func execute() -> Single<[Flight]> {
        return flightsListRepo.flightsList().map{ $0.toDomain() }
    }
}
