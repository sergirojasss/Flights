//
//  FlightsTests.swift
//  FlightsTests
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import XCTest
import RxSwift
@testable import Flights

class FlightsTests: XCTestCase {
    func test_retrieveAllInfo_returns11Flights() {
        let sut = makeSUT()
        expect(sut: sut, expectedResult: 11)
    }

    func test_retrieveAllInfo_returnsError() {
        let sut = makeSUT(endsWithError: true)
        expect(sut: sut, expectedResult: 0, expectedError: ServiceError.decodingData)
    }

}

extension FlightsTests {
    private func makeSUT(endsWithError: Bool = false) -> FlightsUseCase {
        return DefaultFlightsUseCase(flightsListRepo: MockFlightsRepository(endsWithError: endsWithError), airlinesListRepo: MockAirlinesRepository())
    }
    
    private func expect(sut: FlightsUseCase, expectedResult: Int? = 0, expectedError: ServiceError? = nil, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Waiting for info")
        var receivedResult: Int = 0
        var receivedError: ServiceError? = nil
        
        
        sut.loadAllInfo().subscribe { event in
            switch event {
            case .success(let model):
                receivedResult = model.count
            case .failure(let error):
                receivedResult = 0
                receivedError = error as? ServiceError
            }
            XCTAssertEqual(receivedResult, expectedResult, "Expected flights: \(expectedResult), but got \(receivedResult) instead", file: file, line: line)
            XCTAssertEqual(receivedError, expectedError, "Expected error: \(receivedError), but got \(expectedError) instead", file: file, line: line)

            exp.fulfill()
        }.disposed(by: DisposeBag())
        
        wait(for: [exp], timeout: 1.0)
    }
}
