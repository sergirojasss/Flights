//
//  FlightCell.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 20/2/22.
//

import UIKit

extension FlightCell {
    private enum Constants {
        static let contentMode = ContentMode.scaleAspectFill
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

    var airlineLogo: UIImageView = {
        let airlineLogo = UIImageView(frame: .zero)
        airlineLogo.translatesAutoresizingMaskIntoConstraints = false
        
        airlineLogo.contentMode = Constants.contentMode
        airlineLogo.clipsToBounds = true
        airlineLogo.layer.cornerRadius = Constants.cornerRadius
        return airlineLogo
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
        containerView.addSubview(airlineLogo)
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
        self.model = model
        airline.text = model.airlineName
        departure.text = model.departure
        arrival.text = model.arrival
        price.text = model.priceAsString()
        if let url = model.airlineLogo {
            airlineLogo.load(url: url)            
        }

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
        static let logoHeight = 100.0
        static let logoWidth = 100.0
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraints.spacingCells),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraints.leadingWithContentView),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraints.trailingWithContentView),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraints.spacingCells),

            airlineLogo.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constraints.spacingLabels),
            airlineLogo.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constraints.leadingWithContentView),
            airlineLogo.widthAnchor.constraint(equalToConstant: Constraints.logoWidth),
            airlineLogo.heightAnchor.constraint(equalToConstant: Constraints.logoHeight),
            airlineLogo.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            airline.topAnchor.constraint(equalTo: airlineLogo.topAnchor),
            airline.leadingAnchor.constraint(equalTo: airlineLogo.trailingAnchor, constant: Constraints.leadingWithContentView),
            airline.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constraints.trailingWithContentView),
            
            departure.topAnchor.constraint(equalTo: airline.bottomAnchor, constant: Constraints.spacingLabels),
            departure.leadingAnchor.constraint(equalTo: airline.leadingAnchor),
            departure.trailingAnchor.constraint(equalTo: airline.trailingAnchor),

            arrival.topAnchor.constraint(equalTo: departure.bottomAnchor, constant: Constraints.spacingLabels),
            arrival.leadingAnchor.constraint(equalTo: airline.leadingAnchor),
            arrival.trailingAnchor.constraint(equalTo: airline.trailingAnchor),

            price.topAnchor.constraint(equalTo: arrival.bottomAnchor, constant: Constraints.spacingLabels),
            price.leadingAnchor.constraint(equalTo: airline.leadingAnchor),
            price.trailingAnchor.constraint(equalTo: airline.trailingAnchor),
            price.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor),

            contentView.heightAnchor.constraint(equalToConstant: Constraints.totalHeight)
        ])
    }

}
