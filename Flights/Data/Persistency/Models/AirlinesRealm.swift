//
//  AirlinesRealm.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation
import RealmSwift

class AirlinesRealm: Object {
    @Persisted var id: String = ""
    @Persisted var name: String = ""
    @Persisted var headline: String = ""
    @Persisted var airlineDescription: String = ""
    @Persisted var logoImg: String = ""
    @Persisted var mainImg: String = ""
    
    override init() {}

    init(from model: AirlineEntity) {
        self.id = model.id
        self.name = model.name
        self.headline = model.headline
        self.airlineDescription = model.airlineDescription
        self.logoImg = model.logoImg
        self.mainImg = model.mainImg
    }
}

extension AirlinesRealm {
    func toDomain() -> AirlineEntity {
        return AirlineEntity(id: id,
                             name: name,
                             headline: headline,
                             airlineDescription: airlineDescription,
                             logoImg: logoImg,
                             mainImg: mainImg)
    }
}
