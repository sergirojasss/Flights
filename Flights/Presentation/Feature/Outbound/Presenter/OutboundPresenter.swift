//
//  OutboundPresenter.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation
import RxSwift

final class OutboundPresenter {
    let router: OutboundRouterProtocol
    let interactor: OutboundInteractorProtocol
    var view: InboundViewProtocol!
    
    private let disposeBag = DisposeBag()
    
    
    //TODO: Reestructure this
    var outbound: [CellTypes] = [] {
        didSet {
            view.reloadFlights()
        }
    }
    var inbound: [CellTypes] = [] {
        didSet {
            view.reloadFlights()
        }
    }
    var inboundFlightModels: [FlightModel] = []
    var outboundFlightModels: [FlightModel] = []
    
    
    init(withView view: InboundViewProtocol, interactor: OutboundInteractorProtocol, router: OutboundRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension OutboundPresenter: OutboundPresenterProtocol {
    func viewDidload() {
        interactor.getFlights()
            .observe(on: MainScheduler.instance)
            .subscribe{ event in
                switch event {
                case .success(let model):
                    self.inboundFlightModels = model.inbound
                    self.outboundFlightModels = model.outbound
                    self.inbound = model.inbound.map{CellTypes.flightCell(model: FlightCellModel(from: $0))}
                    self.outbound = model.outbound.map{CellTypes.flightCell(model: FlightCellModel(from: $0))}
                case .failure(let error):
                    if let error = error as? ServiceError {
                        self.view.showError(error)
                    }
                    debugPrint("uncontrolled Error")
                }
            }.disposed(by: disposeBag)
    }
    
    func goToInboundFlights(outboundModelId: Int) {
        if let outboundModel = outboundFlightModels.first{ $0.id == outboundModelId } {
            router.goToInboundFlights(outboundModel: outboundModel, inboundFlights: inboundFlightModels)            
        }
    }
}
