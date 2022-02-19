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
    func airlinesList() -> Single<[AirlinesResponse]> {
        
        return Single.create { single -> Disposable in
            //TODO: Magic numbers
            let url = "https://run.mocky.io/v3/786dab92-69c6-4ebd-a447-05e0f3d4cc05"
            
            AF.request(url).response { response in
                switch response.data {
                case .some(let data):
                    guard let response = try? JSONDecoder().decode([AirlinesResponse].self, from: data) else {
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
