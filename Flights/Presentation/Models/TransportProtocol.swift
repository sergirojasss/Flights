//
//  TransportProtocol.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation

protocol Transport {
    var id: Int { get set }
    var price: Float { get set }
    
    func isCombinableWith(transport: Transport) -> Bool
}
