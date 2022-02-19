//
//  AirlinesUseCase.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import RxSwift

protocol AirlinesUseCase {
    func execute() -> Single<[Airline]>
}

final class DefaultAirlinesUseCase: AirlinesUseCase {
    
    private let airlinesListRepo: AirlinesRepository
    
    init(airlinesListRepo: AirlinesRepository = DefaultAirlinesRepository()) {
        self.airlinesListRepo = airlinesListRepo
    }
    
    func execute() -> Single<[Airline]> {
        return airlinesListRepo.airlinesList().map{ $0.toDomain() }
    }
}
