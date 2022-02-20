//
//  FlightCell.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import UIKit

extension FlightCell {
    private enum Constants {
        static let cornerRadius = CGFloat(6.0)
    }
}

final class FlightCell: UITableViewCell, ReusableCell {
    var model: FlightCellModel?
    
    var containerView: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = .gray
        containerView.layer.cornerRadius = Constants.cornerRadius

        return containerView
    }()

    
    var airline: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var departure: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    var arrival: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var price: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    private func setupView() {
        contentView.addSubview(containerView)
        containerView.addSubview(airline)
        containerView.addSubview(departure)
        containerView.addSubview(arrival)
        containerView.addSubview(price)
        setupConstraints()
    }
}

extension FlightCell {
    //MARK: - Public methods
    func getId() -> Int {
        return model?.id ?? -1
    }

    func configure(model: FlightCellModel) {
        airline.text = model.airline
        departure.text = model.departure
        arrival.text = model.arrival
        price.text = model.inbounds

        setupView()
        layoutIfNeeded()
    }

}

extension FlightCell {
    private enum Constraints {
        static let leadingWithContentView = 20.0
        static let trailingWithContentView = 20.0
        static let spacingLabels = 5.0
        static let spacingCells = 5.0
        static let totalHeight = 110.0
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraints.spacingCells),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraints.leadingWithContentView),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraints.trailingWithContentView),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraints.spacingCells),

            
            airline.topAnchor.constraint(equalTo: containerView.topAnchor),
            airline.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constraints.leadingWithContentView),
            airline.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constraints.trailingWithContentView),
            
            departure.topAnchor.constraint(equalTo: airline.bottomAnchor, constant: Constraints.spacingLabels),
            departure.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constraints.leadingWithContentView),
            departure.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constraints.trailingWithContentView),

            arrival.topAnchor.constraint(equalTo: departure.bottomAnchor, constant: Constraints.spacingLabels),
            arrival.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constraints.leadingWithContentView),
            arrival.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constraints.trailingWithContentView),

            price.topAnchor.constraint(equalTo: arrival.bottomAnchor, constant: Constraints.spacingLabels),
            price.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constraints.leadingWithContentView),
            price.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constraints.trailingWithContentView),
            price.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor),

            contentView.heightAnchor.constraint(equalToConstant: Constraints.totalHeight)
        ])
    }

}
