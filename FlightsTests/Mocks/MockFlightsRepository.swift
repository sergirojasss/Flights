//
//  MockFlightsRepository.swift
//  FlightsTests
//
//  Created by ROJAS SERRA Sergi on 21/2/22.
//

import Foundation
import RxSwift
@testable import Flights

final class MockFlightsRepository: FlightsRepository {
    var returnsError: Bool = false
    
    init(endsWithError: Bool) {
        returnsError = endsWithError
    }
    
    func flightsList() -> Single<[FlightEntity]> {
        if returnsError { return .error(ServiceError.decodingData) }
        guard let response = try? JSONDecoder().decode(FlightsListResponse.self, from: serviceResponse!) else {
            return .error(ServiceError.decodingData)
        }
        return .just(response.toDomain())
    }
    
    private let randomFlightEntity: FlightEntity = FlightEntity(id: -1, airline: "", departureAirportCode: "", arrivalAirportCode: "", price: 10.0, type: .inbound)
    
    private let serviceResponse: Data? = "{\"outboundFlights\": [{\"id\": 1,\"airline\": \"Transavia\",\"departureAirportCode\": \"BCN\",\"arrivalAirportCode\": \"AMS\",\"price\": 15},{\"id\": 2,\"airline\": \"Vueling\",\"departureAirportCode\": \"BCN\",\"arrivalAirportCode\": \"AMS\",\"price\": 20},{\"id\": 3,\"airline\": \"Vueling\",\"departureAirportCode\": \"GIR\",\"arrivalAirportCode\": \"AMS\",\"price\": 25},{\"id\": 4,\"airline\": \"Transavia\",\"departureAirportCode\": \"BCN\",\"arrivalAirportCode\": \"AMS\",\"price\": 30},{\"id\": 5,\"airline\": \"Transavia\",\"departureAirportCode\": \"BCN\",\"arrivalAirportCode\": \"ROT\",\"price\": 30},{\"id\": 6,\"airline\": \"Ryanair\",\"departureAirportCode\": \"GIR\",\"arrivalAirportCode\": \"AMS\",\"price\": 32}],\"inboundFlights\": [{\"id\": 11,\"airline\": \"Transavia\",\"departureAirportCode\": \"AMS\",\"arrivalAirportCode\": \"BCN\",\"price\": 50},{\"id\": 12,\"airline\": \"Vueling\",\"departureAirportCode\": \"AMS\",\"arrivalAirportCode\": \"BCN\",\"price\": 30},{\"id\": 13,\"airline\": \"Transavia\",\"departureAirportCode\": \"AMS\",\"arrivalAirportCode\": \"GIR\",\"price\": 25},{\"id\": 14,\"airline\": \"Vueling\",\"departureAirportCode\": \"AMS\",\"arrivalAirportCode\": \"GIR\",\"price\": 30},{\"id\": 15,\"airline\": \"Transavia\",\"departureAirportCode\": \"AMS\",\"arrivalAirportCode\": \"BCN\",\"price\": 30}]}".data(using: .utf8)
}



