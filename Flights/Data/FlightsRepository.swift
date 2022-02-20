//
//  FlightsRepository.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import Alamofire
import RxSwift

final class DefaultFlightsRepository: FlightsRepository {
    
    func flightsList() -> Single<[FlightEntity]> {
        
        return Single.create { single -> Disposable in
            //TODO: Magic numbers
            let url = "https://run.mocky.io/v3/9ae53461-9882-4663-a0f9-919ed6641a75"
            
            AF.request(url).response { response in
                switch response.data {
                case .some(let data):
                    guard let response = try? JSONDecoder().decode(FlightsListResponse.self, from: data) else {
                        single(.failure(ServiceError.mappingError))
                        return
                    }
                    RealmManager.removeFlights()
                    for inbound in response.inboundFlights {
                        RealmManager.addNew(model: FlightsRealm(from: inbound.toDomain(type: FlightType.inbound)))
                    }
                    for outbound in response.outboundFlights {
                        RealmManager.addNew(model: FlightsRealm(from: outbound.toDomain(type: FlightType.outbound)))
                    }
                    
                    single(.success(response.toDomain()))
                default:
                    RealmManager.retrieveFlights() { result in
                        switch result {
                        case .success(let flights):
                            single(.success(flights))
                        case .failure(let error):
                            single(.failure(error))
                        }
                    }
                }
            }
            return Disposables.create()
        }
    }
}
