//
//  AirlinesUseCase.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import RxSwift

protocol AirlinesUseCase {
    func execute() -> Single<[AirlineEntity]?>
}

final class DefaultAirlinesUseCase: AirlinesUseCase {

    private let airlinesListRepo: AirlinesRepository
    
    init(airlinesListRepo: AirlinesRepository = DefaultAirlinesRepository()) {
        self.airlinesListRepo = airlinesListRepo
    }
    
    func execute() -> Single<[AirlineEntity]?> {
        return airlinesListRepo.airlines()
    }
}
