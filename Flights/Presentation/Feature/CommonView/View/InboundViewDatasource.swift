//
//  InboundViewDatasource.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation
import UIKit

final class InboundViewDatasource: NSObject, UITableViewDataSource {
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
        //        tableView?.register(cellType: MainNewCell.self)
        //        tableView?.register(cellType: EmptyCell.self)
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
            return cell
        default:
            return UITableViewCell()
//        case .shimmer:
//            let cell: ShimmerCell = tableView.dequeueReusableCell(for: indexPath)
//            cell.selectionStyle = .none
//            cell.shimmerShinnig()
//            cell.configure()
//            return cell
//        case .newCell(let id, let imageURL, let date, let title, let description):
//            let cell: MainNewCell = tableView.dequeueReusableCell(for: indexPath)
//            let model = MainNewCellModel(id: id, imageURL: imageURL, date: date, title: title, description: description)
//            cell.selectionStyle = .none
//            cell.configure(model: model)
//            return cell
//        case .emptyCell(let title):
//            let cell: EmptyCell = tableView.dequeueReusableCell(for: indexPath)
//            let model = EmptyCellModel(title: title)
//            cell.selectionStyle = .none
//            cell.configure(model: model)
//            return cell
        }
    }
    
    
}
