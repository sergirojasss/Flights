//
//  InboundFlightTests.swift
//  FlightsTests
//
//  Created by ROJAS SERRA Sergi on 21/2/22.
//

import XCTest
import RxSwift
@testable import Flights

// testing
//protocol FlightsUseCase {
//    func getInboundFlights(for outboundFlightId: Int) -> [FlightEntityWithLogo]
//}


class InboundFlightTests: XCTestCase {
    func test_return2Inbound_forOutboundId1() {
        let sut = makeSUT()
        expect(sut: sut, outboundFlightId: 1, expectedResult: 2)
    }
    
    func test_return2Inbound_forOutboundId2() {
        let sut = makeSUT()
        expect(sut: sut, outboundFlightId: 2, expectedResult: 1)
    }

    func test_return2Inbound_forOutboundId3() {
        let sut = makeSUT()
        expect(sut: sut, outboundFlightId: 3, expectedResult: 1)
    }

    func test_return2Inbound_forOutboundId4() {
        let sut = makeSUT()
        expect(sut: sut, outboundFlightId: 4, expectedResult: 2)
    }

    func test_return2Inbound_forOutboundId5() {
        let sut = makeSUT()
        expect(sut: sut, outboundFlightId: 5, expectedResult: 0)
    }

    func test_return2Inbound_forOutboundId6() {
        let sut = makeSUT()
        expect(sut: sut, outboundFlightId: 6, expectedResult: 2)
    }

    func test_return2Inbound_forOutboundId7() {
        let sut = makeSUT()
        expect(sut: sut, outboundFlightId: 7, expectedResult: 0)
    }

}

extension InboundFlightTests {
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
    
    private func expect(sut: FlightsUseCase, outboundFlightId: Int, expectedResult: Int? = 0, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Waiting for info") 
        var receivedResult: Int = 0
        
        
        sut.getOutboundFlights()
            .subscribe { event in
            switch event {
            case .success:
                receivedResult = sut.getInboundFlights(for: outboundFlightId).count
            case .failure:
                receivedResult = 0
            }
            XCTAssertEqual(receivedResult, expectedResult, "Expected flights: \(String(describing: expectedResult)), but got \(receivedResult) instead", file: file, line: line)

            exp.fulfill()
        }.disposed(by: DisposeBag())
        
        wait(for: [exp], timeout: 1.0)
    }
}
