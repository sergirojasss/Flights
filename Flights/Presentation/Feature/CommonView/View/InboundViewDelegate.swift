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
        //TODO: should be automatic
        return 110.0
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: set interaction
        if view?.viewType == .outbound {
            if let cell = tableView.cellForRow(at: indexPath) as? FlightCell {
                view?.presenter?.goToInboundFlights(outboundModelId: cell.getId())
            }
        } else {
            if let cell = tableView.cellForRow(at: indexPath) as? FlightCell {
                view?.inboundPresenter?.showTotalPrice(inboundId: cell.getId())
            }
        }
    }
}
