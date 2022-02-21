//
//  AirlinesRepository.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import Alamofire
import RxSwift

final class DefaultAirlinesRepository: AirlinesRepository {
    func airlines() -> Single<[AirlineEntity]?> {
        
        return Single.create { single -> Disposable in
            let url = EndPoints.airlines
            
            AF.request(url).response { response in
                switch response.data {
                case .some(let data):
                    guard let response = try? JSONDecoder().decode([AirlinesResponse].self, from: data) else {
                        single(.failure(ServiceError.mappingError))
                        return
                    }
                    RealmManager.removeAirlines()
                    for airline in response {
                        RealmManager.addNew(model: AirlinesRealm.init(from: airline.toDomain()))
                    }
                    single(.success(response.map{$0.toDomain()}))
                default:
                    RealmManager.retrieveAirlines() { result in
                        switch result {
                        case .success(let airlines):
                            single(.success(airlines))
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
