//
//  InboundViewDelegate.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import Foundation
import UIKit

final class InboundViewDelegate: NSObject, UITableViewDelegate {
    private var view: InOutCommonViewController?

    init(view: InOutCommonViewController?) {
        self.view = view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FlightCell else { return }
        if view?.viewType == .outbound {
            view?.presenter?.goToInboundFlights(outboundModelId: cell.getId())
        } else {
            view?.inboundPresenter?.showTotalPrice(inboundId: cell.getId())
        }
    }
}
