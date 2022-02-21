//
//  FlightsUseCase.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import RxSwift
import SwiftUI

enum orderFlightsPrice {
    case asc, desc
}

protocol FlightsUseCase {
    func loadAllInfo() -> Single<([FlightEntityWithLogo])>
    func getInboundFlights(for outboundFlightId: Int) -> [FlightEntityWithLogo]
    func getFlight(for id: Int) -> FlightEntityWithLogo?
}

protocol FlightsUseCaseDependenciesProtocol {
    var flightsListRepo: FlightsRepository { get set }
    var airlinesListRepo: AirlinesRepository { get set }
}

final class DefaultFlightsUseCaseDependencies: FlightsUseCaseDependenciesProtocol {
    lazy var flightsListRepo: FlightsRepository = DefaultFlightsRepository()
    lazy var airlinesListRepo: AirlinesRepository = DefaultAirlinesRepository()
    
    init(flightsListRepo: FlightsRepository = DefaultFlightsRepository(),
         airlinesListRepo: AirlinesRepository = DefaultAirlinesRepository()) {
        self.flightsListRepo = flightsListRepo
        self.airlinesListRepo = airlinesListRepo
    }
}

final class DefaultFlightsUseCase: FlightsUseCase {
    
    private let dependencies: FlightsUseCaseDependenciesProtocol
    
    var flights: [FlightEntityWithLogo] = []
    var airlines: [AirlineEntity] = []
    
    init(dependencies: FlightsUseCaseDependenciesProtocol = DefaultFlightsUseCaseDependencies()) {
        self.dependencies = dependencies
    }
    
    //MARK: - Public methods
    func loadAllInfo() -> Single<([FlightEntityWithLogo])> {
        return Single.zip(getFlights(orderBy: .asc),
                          getAirlines())
            .observe(on: MainScheduler.instance)
            .flatMap{ model in
                self.airlines = model.1 ?? []
                self.flights = self.getEveryFlightWithLogo(flights: model.0)
                return .just(self.flights)
            }.catch { error in
                return .error(error)
            }
    }
    
    func getInboundFlights(for outboundFlightId: Int) -> [FlightEntityWithLogo] {
        guard let flightWLogo = getFlightWithLogo(flightId: outboundFlightId) else { return [] }
        let inbounds = flights.filter({ flightEntity in
            flightEntity.type == .inbound
        })
        if !inbounds.isEmpty {
            let matching = flightWLogo.isCombinableWith(transports: inbounds)
            return matching
        }
        return []
    }
    
    func getFlight(for id: Int) -> FlightEntityWithLogo? {
        getFlightWithLogo(flightId: id)
    }
}

//MARK: - Private methods
extension DefaultFlightsUseCase {
    private func getAirlines() -> Single<[AirlineEntity]?> {
        dependencies.airlinesListRepo.airlines()
    }
    
    private func getFlights(orderBy: orderFlightsPrice) -> Single<[FlightEntity]> {
        dependencies.flightsListRepo.flightsList().map{ $0.sorted { lhs, rhs in
            orderBy == .asc ? lhs.price < rhs.price : lhs.price > rhs.price
        } }
    }
    
    
    private func getEveryFlightWithLogo(flights: [FlightEntity]) -> [FlightEntityWithLogo] {
        var flightsWithLogo = [FlightEntityWithLogo]()
        for flight in flights {
            if let airline = airlines.first(where: { airlineEntity in
                airlineEntity.id == flight.airline
            }) {
                flightsWithLogo.append(FlightEntityWithLogo(from: flight, logo: URL(string: airline.logoImg)))
            } else {
                flightsWithLogo.append(FlightEntityWithLogo(from: flight, logo: nil))
            }
        }
        return flightsWithLogo
    }
    
    private func getFlightWithLogo(flightId: Int) -> FlightEntityWithLogo? {
        if let flight = flights.first(where: { $0.id == flightId }) {
            return flight
        }
        return nil
    }
}

