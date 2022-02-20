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
    
    var inboundFlightModels: [FlightModel] = []
    var outboundFlightModels: [FlightModel] = []
    var airlines: [AirlineModel] = []
    
    
    init(withView view: InboundViewProtocol, interactor: OutboundInteractorProtocol, router: OutboundRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension OutboundPresenter: OutboundPresenterProtocol {
    func viewDidload() {
        Single.zip(interactor.getFlights(), interactor.getAirlines())
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success(let model):
                    self.inboundFlightModels = model.0.inbound
                    self.outboundFlightModels = model.0.outbound
                    self.airlines = model.1 ?? []
                    self.view.reloadFlights()
                case .failure(let error):
                    if let _ = error as? ServiceError {
                            guard let error = error as? ServiceError else { return }
                            self.view.showError(error)
                    } else {
                        debugPrint("uncontrolled Error")
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    func getAirline(for name: String) -> AirlineModel? {
        airlines.first { airlineModel in airlineModel.id == name }
    }
    

    func goToInboundFlights(outboundModelId: Int) {
        if let outboundModel = outboundFlightModels.first(where: { $0.id == outboundModelId }) {
            router.goToInboundFlights(airlines: airlines, outboundModel: outboundModel, inboundFlights: inboundFlightModels)
        }
    }
}
