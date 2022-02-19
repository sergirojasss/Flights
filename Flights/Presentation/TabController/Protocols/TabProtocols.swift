//
//  TabProtocols.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import RxSwift

protocol TabViewProtocol {
    
}

protocol TabRouterProtocol {
    
}

protocol TabInteractorProtocol {
    func loadFlightsAndAirports() -> Single<([Flight],[Airline])>
    func saveAirlines()
    func saveFlights()
}

protocol TabPresenterProtocol {
    func viewDidLoad()
}

