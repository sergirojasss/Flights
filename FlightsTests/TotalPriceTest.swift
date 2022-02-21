//
//  TotalPriceTest.swift
//  FlightsTests
//
//  Created by ROJAS SERRA Sergi on 21/2/22.
//

import XCTest
import RxSwift
@testable import Flights

// testing
//protocol FlightsUseCase {
//    func getTotalPrice(outboundId: Int, inboundId: Int) -> Float?
//}


class TotalPriceTest: XCTestCase {
    func test_totalPrice_withCorrectId_withCorrectId_delivers35() {
        let sut = makeSUT()
        expect(sut: sut, outboundFlightId: 1, inboundFlightId: 2, expectedResult: 35.0)
    }

    func test_totalPrice_withIncorrectId_withCorrectId_deliversNil() {
        let sut = makeSUT()
        expect(sut: sut, outboundFlightId: -1, inboundFlightId: 2, expectedResult: nil)
    }

    func test_totalPrice_withCorrectId_withIncorrectId_deliversNil() {
        let sut = makeSUT()
        expect(sut: sut, outboundFlightId: 1, inboundFlightId: -1, expectedResult: nil)
    }

    func test_totalPrice_withIncorrectId_withIncorrectId_deliversNil() {
        let sut = makeSUT()
        expect(sut: sut, outboundFlightId: -1, inboundFlightId: -1, expectedResult: nil)
    }
}

extension TotalPriceTest {
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
    
    private func expect(sut: FlightsUseCase, outboundFlightId: Int, inboundFlightId: Int, expectedResult: Float? = 0.0, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Waiting for info")
        var receivedResult: Float? = 0.0
        
        
        sut.getOutboundFlights()
            .subscribe { event in
            switch event {
            case .success:
                receivedResult = sut.getTotalPrice(outboundId: outboundFlightId, inboundId: inboundFlightId)
            case .failure:
                receivedResult = -1
            }
                XCTAssertEqual(receivedResult, expectedResult, "Expected flights: \(String(describing: expectedResult)), but got \(String(describing: receivedResult)) instead", file: file, line: line)

            exp.fulfill()
        }.disposed(by: DisposeBag())
        
        wait(for: [exp], timeout: 1.0)
    }
}
