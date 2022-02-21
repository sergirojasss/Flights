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
        
        containerView.backgroundColor = .gray.withAlphaComponent(0.2)
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
    
    var planeImage: UIImageView = {
        let planeImage = UIImageView(frame: .zero)
        planeImage.translatesAutoresizingMaskIntoConstraints = false
        
        planeImage.contentMode = Constants.contentMode
        planeImage.clipsToBounds = true
        planeImage.layer.cornerRadius = Constants.cornerRadius
        planeImage.image = UIImage(named: "airplane")
        return planeImage
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
        containerView.addSubview(departure)
        containerView.addSubview(planeImage)
        containerView.addSubview(arrival)
        containerView.addSubview(airlineLogo)
        containerView.addSubview(airline)

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
        static let topWithContentView = 20.0
        static let spacingLabels = 10.0
        static let spacingCells = 5.0
        static let logoHeight = 50.0
        static let logoWidth = 50.0
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.spacingCells),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.leadingWithContentView),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.trailingWithContentView),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.spacingCells),
            
            departure.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constraints.topWithContentView),
            departure.heightAnchor.constraint(equalToConstant: 20.5),
            departure.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constraints.leadingWithContentView),
            departure.trailingAnchor.constraint(equalTo: planeImage.leadingAnchor, constant: -Constraints.spacingLabels),
            departure.bottomAnchor.constraint(lessThanOrEqualTo: airlineLogo.topAnchor),
            
            planeImage.centerYAnchor.constraint(equalTo: departure.centerYAnchor),
            planeImage.trailingAnchor.constraint(equalTo: arrival.leadingAnchor, constant: -Constraints.spacingLabels),
            planeImage.widthAnchor.constraint(equalToConstant: 15.0),
            planeImage.heightAnchor.constraint(equalToConstant: 15.0),
            
            arrival.centerYAnchor.constraint(equalTo: departure.centerYAnchor),
            
            airlineLogo.leadingAnchor.constraint(equalTo: departure.leadingAnchor),
            airlineLogo.heightAnchor.constraint(equalToConstant: 25.0),
            airlineLogo.widthAnchor.constraint(equalToConstant: 25.0),
            airlineLogo.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constraints.spacingLabels),
            
            airline.centerYAnchor.constraint(equalTo: airlineLogo.centerYAnchor),
            airline.leadingAnchor.constraint(equalTo: airlineLogo.trailingAnchor, constant: Constraints.spacingLabels),
            
            price.leadingAnchor.constraint(greaterThanOrEqualTo: arrival.trailingAnchor, constant: Constraints.spacingLabels),
            price.leadingAnchor.constraint(greaterThanOrEqualTo: airline.trailingAnchor, constant: Constraints.spacingLabels),
            price.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constraints.trailingWithContentView),
            price.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
    }

}
