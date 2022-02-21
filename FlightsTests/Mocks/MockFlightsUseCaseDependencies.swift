//
//  MockFlightsUseCaseDependencies.swift
//  FlightsTests
//
//  Created by ROJAS SERRA Sergi on 21/2/22.
//

import Foundation
@testable import Flights

final class MockFlightsUseCaseDependencies: FlightsUseCaseDependenciesProtocol {
    var flightsListRepo: FlightsRepository
    var airlinesListRepo: AirlinesRepository
    
    init(flightsEndsWithError: Bool = false,
         flightReturnsMappingError: Bool = false,
         airlinesEndsWithError: Bool = false,
         airlinesReturnsMappingError: Bool = false) {
        self.flightsListRepo = MockFlightsRepository(endsWithError: flightsEndsWithError,
                                                     returnsMappingError: flightReturnsMappingError)
        self.airlinesListRepo = MockAirlinesRepository(endsWithError: airlinesEndsWithError,
                                                       returnsMappingError: airlinesReturnsMappingError)
    }
    
}
