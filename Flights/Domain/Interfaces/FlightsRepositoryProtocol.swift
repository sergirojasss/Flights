//
//  FlightsRepository.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import RxSwift

protocol FlightsRepository {
    func flightsList() -> Single<FlightsListResponse>
}
