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
    func flightsList() -> Single<FlightsListResponse> {
        
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
                    single(.success(response))
                default:
                    single(.failure(ServiceError.responseError))
                }
            }
            return Disposables.create()
        }
    }
}
