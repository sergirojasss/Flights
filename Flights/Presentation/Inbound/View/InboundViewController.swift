//
//  InboundViewController.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import UIKit
import RxSwift

final class InboundViewController: UIViewController {
    var presenter: InboundPresenterProtocol!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }    
}

extension InboundViewController: InboundViewProtocol {
    
}
