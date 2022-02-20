//
//  InboundViewDelegate.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation
import UIKit

final class InboundViewDelegate: NSObject, UITableViewDelegate {
    private var view: InboundViewController?

    init(view: InboundViewController?) {
        self.view = view
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: set interaction
//        if let cell = tableView.cellForRow(at: indexPath) as? MainNewCell {
//            view?.goToDetail(id: cell.getId())
//        }
    }
}
