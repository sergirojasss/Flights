//
//  InboundViewDatasource.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation
import UIKit

final class InboundViewDatasource: NSObject, UITableViewDataSource {
    
    /// Cells to show on table view
    /// - Parameter [CellTypes]?: [CellTypes.flightCell(model: FlightCellModel)] or [CellTypes.shimmerCell]
    var datasource: [CellTypes]? {
        didSet {
            tableView?.reloadData()
        }
    }
    private var tableView: UITableView?

    init(tableView: UITableView)
    {
        self.tableView = tableView
    }

    func registerCells() {
        tableView?.register(cellType: FlightCell.self)
        tableView?.register(cellType: ShimmerCell.self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = datasource?[indexPath.row] else {
            return UITableViewCell()
        }

        switch cellType {
        case .flightCell(let model):
            let cell: FlightCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(model: model)
            cell.selectionStyle = .none
            return cell
        case .shimmer:
            let cell: ShimmerCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure()
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
