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
            .subscribe { [weak self] event in
                switch event {
                case .success(let airlines, let flights):
                    print(airlines)
                    print(flights)
                case .failure(let error):
                    print(error)
                }
            }.disposed(by: disposeBag)
    }
}
