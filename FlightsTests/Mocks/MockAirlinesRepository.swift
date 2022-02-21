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
    var returnsError: Bool = false
    var returnsMappingError: Bool = false
    
    init(endsWithError: Bool = false,
         returnsMappingError: Bool = false) {
        returnsError = endsWithError
        self.returnsMappingError = returnsMappingError
    }

    func airlines() -> Single<[AirlineEntity]?> {
        if returnsError { return .error(ServiceError.responseError) }
        if returnsMappingError {
            guard let response = try? JSONDecoder().decode([AirlinesResponse].self, from: wrongServiceResponse!) else {
                return .error(ServiceError.decodingData)
            }
        }
        guard let response = try? JSONDecoder().decode([AirlinesResponse].self, from: serviceResponse!) else {
            return .error(ServiceError.decodingData)
        }
        return .just(response.map{$0.toDomain()})
    }
    
    
    private let serviceResponse: Data? = "[{  \"id\": \"Transavia\",  \"name\": \"Transavia\",  \"headline\": \"Want to fly affordably to more than 100 destinations in Europe? Book a flight with Transavia!\",  \"description\": \"Transavia is a low-cost airline that for the past 50 years has taken great pleasure in flying passengers to over 110 destinations in Europe and North Africa. Transavia stands for accessibility and affordability: whether you are planning a holiday or a business trip, you will always find a flight that fits your budget. Transavia operates from the Netherlands and France.\",  \"logoImg\": \"https://via.placeholder.com/100x100/32a852/ffffff?text=TR\",  \"mainImg\": \"https://cdn.pixabay.com/photo/2017/03/24/19/53/plane-2172059_1280.jpg\"},{  \"id\": \"Iberia\",  \"name\": \"Iberia\",  \"headline\": \"Fancy pizza or cappuccino? Book your flight to Rome now.\",  \"description\": \"Iberia, legally incorporated as Iberia, Líneas Aéreas de España, S.A. Operadora, Sociedad Unipersonal, is the flag carrier airline of Spain, founded in 1927. Based in Madrid, it operates an international network of services from its main base of Madrid-Barajas Airport.\",  \"logoImg\": \"http://via.placeholder.com/100x100/e83a3a/ffffff?text=IB\",  \"mainImg\": \"https://cdn.pixabay.com/photo/2017/03/21/22/28/aircraft-2163503_1280.jpg\"},{  \"id\": \"Vueling\",  \"name\": \"Vueling (Vueling Airlines)\",  \"headline\": \"But out out from 19.99€\",  \"description\": \"Vueling Airlines, S.A. is a Spanish low-cost airline based at El Prat de Llobregat in Greater Barcelona with hubs at Barcelona–El Prat Airport and Leonardo da Vinci–Fiumicino Airport in Rome, Italy. It is the largest airline in Spain, measured by fleet size and number of destinations.\",  \"logoImg\": \"https://via.placeholder.com/100x100/e8d935/5c5c5c?text=VUE\",  \"mainImg\": \"https://cdn.pixabay.com/photo/2016/09/27/19/57/airbus-a320-1699203_1280.jpg\"},{  \"id\": \"Ryanair\",  \"name\": \"Ryanair\",  \"headline\": \"Always Getting Better\",  \"description\": \"Ryanair DAC is an Irish budget airline founded in 1984, headquartered in Swords, Dublin, Ireland, with its primary operational bases at Dublin and London Stansted airports. It forms the largest part of the Ryanair Holdings family of airlines, and has Ryanair UK, Ryanair Sun, Malta Air and Lauda as sister airlines.\",  \"logoImg\": \"http://via.placeholder.com/100x100/2761d6/ffffff?text=RY\",  \"mainImg\": \"https://cdn.pixabay.com/photo/2019/03/19/13/08/airplane-4065698_1280.jpg\"}]".data(using: .utf8)

    private let wrongServiceResponse: Data? = "[{  \"idd\": \"Transavia\",  \"name\": \"Transavia\",  \"headline\": \"Want to fly affordably to more than 100 destinations in Europe? Book a flight with Transavia!\",  \"description\": \"Transavia is a low-cost airline that for the past 50 years has taken great pleasure in flying passengers to over 110 destinations in Europe and North Africa. Transavia stands for accessibility and affordability: whether you are planning a holiday or a business trip, you will always find a flight that fits your budget. Transavia operates from the Netherlands and France.\",  \"logoImg\": \"https://via.placeholder.com/100x100/32a852/ffffff?text=TR\",  \"mainImg\": \"https://cdn.pixabay.com/photo/2017/03/24/19/53/plane-2172059_1280.jpg\"},{  \"id\": \"Iberia\",  \"name\": \"Iberia\",  \"headline\": \"Fancy pizza or cappuccino? Book your flight to Rome now.\",  \"description\": \"Iberia, legally incorporated as Iberia, Líneas Aéreas de España, S.A. Operadora, Sociedad Unipersonal, is the flag carrier airline of Spain, founded in 1927. Based in Madrid, it operates an international network of services from its main base of Madrid-Barajas Airport.\",  \"logoImg\": \"http://via.placeholder.com/100x100/e83a3a/ffffff?text=IB\",  \"mainImg\": \"https://cdn.pixabay.com/photo/2017/03/21/22/28/aircraft-2163503_1280.jpg\"},{  \"id\": \"Vueling\",  \"name\": \"Vueling (Vueling Airlines)\",  \"headline\": \"But out out from 19.99€\",  \"description\": \"Vueling Airlines, S.A. is a Spanish low-cost airline based at El Prat de Llobregat in Greater Barcelona with hubs at Barcelona–El Prat Airport and Leonardo da Vinci–Fiumicino Airport in Rome, Italy. It is the largest airline in Spain, measured by fleet size and number of destinations.\",  \"logoImg\": \"https://via.placeholder.com/100x100/e8d935/5c5c5c?text=VUE\",  \"mainImg\": \"https://cdn.pixabay.com/photo/2016/09/27/19/57/airbus-a320-1699203_1280.jpg\"},{  \"id\": \"Ryanair\",  \"name\": \"Ryanair\",  \"headline\": \"Always Getting Better\",  \"description\": \"Ryanair DAC is an Irish budget airline founded in 1984, headquartered in Swords, Dublin, Ireland, with its primary operational bases at Dublin and London Stansted airports. It forms the largest part of the Ryanair Holdings family of airlines, and has Ryanair UK, Ryanair Sun, Malta Air and Lauda as sister airlines.\",  \"logoImg\": \"http://via.placeholder.com/100x100/2761d6/ffffff?text=RY\",  \"mainImg\": \"https://cdn.pixabay.com/photo/2019/03/19/13/08/airplane-4065698_1280.jpg\"}]".data(using: .utf8)
}
