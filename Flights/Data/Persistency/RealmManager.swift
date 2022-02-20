//
//  RealmManager.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation
import RealmSwift
import RxSwift

final class RealmManager {
    public static func addNew(model: FlightsRealm) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(model)
            }
        } catch {
            debugPrint("ERROR creating realm database.")
        }
    }

    public static func retrieveFlights(completionHandler: @escaping (Result<[FlightEntity], ServiceError>) -> Void) {
        do {
            let realm = try Realm()
            let flights = realm.objects(FlightsRealm.self)
            
            var response: [FlightEntity] = []
            for flight in flights {
                response.append(flight.toDomain())
            }

            completionHandler(.success(response))
        } catch {
            debugPrint("ERROR creating realm database.")
            completionHandler(.failure(ServiceError.decodingData))
        }
    }
    
    public static func removeFlights() {
        do {
            let realm = try Realm()
            let flights = realm.objects(FlightsRealm.self)
            try realm.write {
                realm.delete(flights)
            }
        } catch {
            debugPrint("ERROR deleting realm database.")
        }
            
    }
    
    public static func addNew(model: AirlinesRealm) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(model)
            }
        } catch {
            debugPrint("ERROR creating realm database.")
        }
    }

    public static func retrieveAirlines(completionHandler: @escaping (Result<[AirlineEntity], ServiceError>) -> Void) {
        do {
            let realm = try Realm()
            let airlines = realm.objects(AirlinesRealm.self)

            var response: [AirlineEntity] = []
            for airline in airlines {
                response.append(airline.toDomain())
            }

            completionHandler(.success(response))
        } catch {
            debugPrint("ERROR creating realm database.")
            completionHandler(.failure(ServiceError.decodingData))
        }
    }
    
    public static func removeAirlines() {
        do {
            let realm = try Realm()
            let airlines = realm.objects(AirlinesRealm.self)
            try realm.write {
                realm.delete(airlines)
            }
        } catch {
            debugPrint("ERROR deleting realm database.")
        }
            
    }
}
