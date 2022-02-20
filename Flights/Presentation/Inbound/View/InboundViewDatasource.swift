//
//  InboundViewDatasource.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation
import UIKit

final class InboundViewDatasource: NSObject, UITableViewDataSource {
    private var datasource: [FlightModel]
    private var tableView: UITableView?

    init(datasource: [FlightModel],
         tableView: UITableView)
    {
        self.datasource = datasource
        self.tableView = tableView
    }

    func registerCells() {
//        tableView?.register(cellType: ShimmerCell.self)
//        tableView?.register(cellType: MainNewCell.self)
//        tableView?.register(cellType: EmptyCell.self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
