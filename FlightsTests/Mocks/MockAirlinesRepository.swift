//
//  MockAirlinesRepository.swift
//  FlightsTests
//
//  Created by ROJAS SERRA Sergi on 21/2/22.
//

import Foundation
import RxSwift
@testable import Flights

final class MockAirlinesRepository: AirlinesRepository {
    func airlines() -> Single<[AirlineEntity]?> {
        return .just(nil)
    }
}
