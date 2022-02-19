//
//  TabViewController.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import UIKit
import RxSwift

final class TabViewController: UITabBarController, UITabBarControllerDelegate {
    var presenter: TabPresenterProtocol!
    
    private let useCase: AirlinesUseCase = DefaultAirlinesUseCase()
    private let useCase2: FlightsUseCase = DefaultFlightsUseCase()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        presenter.viewDidLoad()
        
        self.delegate = self
        
        // Create Tab one
        let tabOne = InboundRouter.assembleModule()
        let tabOneBarItem = UITabBarItem(title: "Tab 1", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
    
        tabOne.tabBarItem = tabOneBarItem
        
        
        // Create Tab two
        let tabTwo = OutboundRouter.assembleModule()
        let tabTwoBarItem2 = UITabBarItem(title: "Tab 2", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
        self.viewControllers = [tabOne, tabTwo]
        
        view.backgroundColor = .white
        
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController)")
    }

}

extension TabViewController: TabViewProtocol {
    
}
