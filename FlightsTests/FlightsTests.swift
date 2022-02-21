//
//  FlightsTests.swift
//  FlightsTests
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import XCTest
import RxSwift
@testable import Flights

// testing
//protocol FlightsUseCase {
//    func getOutboundFlights() -> Single<([FlightEntityWithLogo])>
//}


class FlightsTests: XCTestCase {
    func test_retrieveAllInfo_returns6Flights() {
        let sut = makeSUT()
        expect(sut: sut, expectedResult: 6)
    }

    //MARK: - responseError testing
    func test_retrieveAllInfo_flightsRepoEndsWithError_airlinesRepoEndsWithError_deliversServiceResponseError() {
        let sut = makeSUT(flightsEndsWithError: true, airlinesEndsWithError: true)
        expect(sut: sut, expectedResult: 0, expectedError: ServiceError.responseError)
    }

    func test_retrieveAllInfo_flightsRepoEndsWithNoError_airlinesRepoEndsWithError_deliversServiceResponseError() {
        let sut = makeSUT(flightsEndsWithError: false, airlinesEndsWithError: true)
        expect(sut: sut, expectedResult: 0, expectedError: ServiceError.responseError)
    }

    func test_retrieveAllInfo_flightsRepoEndsWithError_airlinesRepoEndsWithNoError_deliversServiceResponseError() {
        let sut = makeSUT(flightsEndsWithError: true, airlinesEndsWithError: false)
        expect(sut: sut, expectedResult: 0, expectedError: ServiceError.responseError)
    }
    
    //MARK: - Decoding testing
    func test_retrieveAllInfo_flightMappingError_deliversServiceDecodingError() {
        let sut = makeSUT(flightsReturnsMappingError: true)
        expect(sut: sut, expectedResult: 0, expectedError: ServiceError.decodingData)
    }

    func test_retrieveAllInfo_airlineMappingError_deliversServiceDecodingError() {
        let sut = makeSUT(airlinesReturnsMappingError: true)
        expect(sut: sut, expectedResult: 0, expectedError: ServiceError.decodingData)
    }
}

extension FlightsTests {
    private func makeSUT(flightsEndsWithError: Bool = false,
                         flightsReturnsMappingError: Bool = false,
                         airlinesEndsWithError: Bool = false,
                         airlinesReturnsMappingError: Bool = false) -> FlightsUseCase {
        
        return DefaultFlightsUseCase(dependencies:
                                        MockFlightsUseCaseDependencies(
                                            flightsEndsWithError: flightsEndsWithError,
                                            flightReturnsMappingError: flightsReturnsMappingError,
                                            airlinesEndsWithError: airlinesEndsWithError,
                                            airlinesReturnsMappingError: airlinesReturnsMappingError))
        }
    
    private func expect(sut: FlightsUseCase, expectedResult: Int? = 0, expectedError: ServiceError? = nil, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Waiting for info")
        var receivedResult: Int = 0
        var receivedError: ServiceError? = nil
        
        
        sut.getOutboundFlights().subscribe { event in
            switch event {
            case .success(let model):
                receivedResult = model.count
            case .failure(let error):
                receivedResult = 0
                receivedError = error as? ServiceError
            }
            XCTAssertEqual(receivedResult, expectedResult, "Expected flights: \(String(describing: expectedResult)), but got \(receivedResult) instead", file: file, line: line)
            XCTAssertEqual(receivedError, expectedError, "Expected error: \(String(describing: receivedError)), but got \(String(describing: expectedError)) instead", file: file, line: line)

            exp.fulfill()
        }.disposed(by: DisposeBag())
        
        wait(for: [exp], timeout: 1.0)
    }
}
