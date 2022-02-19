//
//  AirlinesRepository.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import RxSwift

protocol AirlinesRepository {
    func airlinesList() -> Single<[AirlinesResponse]>
}
