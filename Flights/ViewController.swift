//
//  ViewController.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    private let disposeBag: DisposeBag = DisposeBag()
    private let useCase: AirlinesUseCase = DefaultAirlinesUseCase()
    private let useCase2: FlightsUseCase = DefaultFlightsUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Single.zip(useCase.execute(), useCase2.execute())
            .map { (airlines, flights) -> ([Airline], [Flight]) in
                let xxx = airlines
                let eee = flights
                return (airlines, flights)
            }.catch  { Error in
                    .error(ServiceError.responseError)
            }
        //            .catchErrorJustReturn(
        //                ([],[])
        //            )
        
        //        useCase.execute()
        //            .observe(on: MainScheduler.instance)
        //            .subscribe{ event in
        //                switch event {
        //                case .success(let airlinesList):
        //                    let airliens = airlinesList
        //                    print(airliens)
        //                case .failure(_):
        //                    //TODO: failure case
        //                    break
        //                }
        //            }.disposed(by: disposeBag)
        //
        //        useCase2.execute()
        //            .observe(on: MainScheduler.instance)
        //            .subscribe{ event in
        //                switch event {
        //                case .success(let flights):
        //                    let flights = flights
        //                    print(flights)
        //                case .failure(_):
        //                    //TODO: failure case
        //                    break
        //                }
        //            }.disposed(by: disposeBag)
    }
}
