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
    
    private enum Fonts {
        static let titleLabelFont = UIFont.semibold(size: 16)
        static let priceLabelFont = UIFont.extraBold(size: 20)
        static let descriptionLabelFont = UIFont.regular(size: 11)
    }

    private enum Colors {
        static let titleLabelColor = UIColor.customBlack
        static let priceLabelColor = UIColor.customBlue
        static let descriptionLabelColor = UIColor.customGray
        static let shadowColor = UIColor.customBlack.cgColor
        static let borderBackgroundColor = UIColor.white
    }
}

final class FlightCell: UITableViewCell, ReusableCell {
    private var model: FlightCellModel?
    
    private var containerView: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = .gray.withAlphaComponent(0.2)
        containerView.layer.cornerRadius = Constants.cornerRadius
        return containerView
    }()

    private var separatorView: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = Colors.priceLabelColor.withAlphaComponent(0.4)
        containerView.layer.cornerRadius = Constants.cornerRadius
        return containerView
    }()

    private var airlineLogo: UIImageView = {
        let airlineLogo = UIImageView(frame: .zero)
        airlineLogo.translatesAutoresizingMaskIntoConstraints = false
        
        airlineLogo.contentMode = Constants.contentMode
        airlineLogo.clipsToBounds = true
        airlineLogo.layer.cornerRadius = Constants.cornerRadius
        return airlineLogo
    }()
    
    private var planeImage: UIImageView = {
        let planeImage = UIImageView(frame: .zero)
        planeImage.translatesAutoresizingMaskIntoConstraints = false
        
        planeImage.contentMode = Constants.contentMode
        planeImage.clipsToBounds = true
        planeImage.layer.cornerRadius = Constants.cornerRadius
        planeImage.image = UIImage(named: "airplane")
        return planeImage
    }()
    
    private var airline: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = Fonts.titleLabelFont
        label.textColor = Colors.titleLabelColor
        return label
    }()

    private var airlineHeadline: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = Fonts.descriptionLabelFont
        label.textColor = Colors.descriptionLabelColor
        label.numberOfLines = 0
        return label
    }()

    private var departure: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = Fonts.titleLabelFont
        label.textColor = Colors.titleLabelColor
        return label
    }()

    private var arrival: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = Fonts.titleLabelFont
        label.textColor = Colors.titleLabelColor
        return label
    }()
    
    private var price: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = Fonts.priceLabelFont
        label.textColor = Colors.priceLabelColor
        return label
    }()

    private func setupView() {
        contentView.addSubview(containerView)
        containerView.addSubview(departure)
        containerView.addSubview(planeImage)
        containerView.addSubview(arrival)
        containerView.addSubview(airlineLogo)
        containerView.addSubview(airline)
        containerView.addSubview(separatorView)
        containerView.addSubview(airlineHeadline)
        containerView.addSubview(price)
        
        setupConstraints()
    }
}

extension FlightCell {
    //MARK: - Public methods
    func getId() -> Int {
        return model?.id ?? -1
    }

    /// Public method to print cell
    /// - Parameter model: FlightCellModel
    func configure(model: FlightCellModel) {
        self.model = model
        airline.text = model.airlineName
        departure.text = model.departure
        arrival.text = model.arrival
        price.text = model.priceAsString()
        if let url = model.airlineLogo {
            airlineLogo.load(url: url)            
        }
        airlineHeadline.text = model.airlineHeadline

        self.setupView()
    }
}

extension FlightCell {
    private enum Constraints {
        static let leadingWithContentView = 20.0
        static let trailingWithContentView = 20.0
        static let topWithContentView = 20.0
        static let spacingLabels = 10.0
        static let spacingCells = 5.0
        static let logoSize = 25.0
        static let imgSize = 25.0
        static let separatorHeight = 2.0
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraints.spacingCells),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraints.leadingWithContentView),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraints.trailingWithContentView),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraints.spacingCells),
            
            departure.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constraints.topWithContentView),
            departure.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constraints.leadingWithContentView),
            departure.trailingAnchor.constraint(equalTo: planeImage.leadingAnchor, constant: -Constraints.spacingLabels),
            departure.bottomAnchor.constraint(equalTo: airlineLogo.topAnchor, constant: -Constraints.topWithContentView),
            
            planeImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constraints.topWithContentView),
            planeImage.centerYAnchor.constraint(equalTo: departure.centerYAnchor),
            planeImage.trailingAnchor.constraint(equalTo: arrival.leadingAnchor, constant: -Constraints.spacingLabels),
            planeImage.widthAnchor.constraint(equalToConstant: Constraints.imgSize),
            planeImage.heightAnchor.constraint(equalToConstant: Constraints.imgSize),
            
            arrival.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constraints.topWithContentView),
            arrival.centerYAnchor.constraint(equalTo: departure.centerYAnchor),
            
            airlineLogo.leadingAnchor.constraint(equalTo: departure.leadingAnchor),
            airlineLogo.heightAnchor.constraint(equalToConstant: Constraints.logoSize),
            airlineLogo.widthAnchor.constraint(equalToConstant: Constraints.logoSize),
            
            airline.centerYAnchor.constraint(equalTo: airlineLogo.centerYAnchor),
            airline.leadingAnchor.constraint(equalTo: airlineLogo.trailingAnchor, constant: Constraints.spacingLabels),
            
            price.leadingAnchor.constraint(greaterThanOrEqualTo: arrival.trailingAnchor, constant: Constraints.spacingLabels),
            price.leadingAnchor.constraint(greaterThanOrEqualTo: airline.trailingAnchor, constant: Constraints.spacingLabels),
            price.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constraints.trailingWithContentView),
            price.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constraints.topWithContentView),
            price.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -Constraints.topWithContentView),

            separatorView.topAnchor.constraint(equalTo: airlineLogo.bottomAnchor, constant: Constraints.topWithContentView),
            separatorView.leadingAnchor.constraint(equalTo: airlineLogo.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: price.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: Constraints.separatorHeight),
            
            airlineHeadline.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Constraints.topWithContentView),
            airlineHeadline.leadingAnchor.constraint(equalTo: separatorView.leadingAnchor),
            airlineHeadline.trailingAnchor.constraint(equalTo: separatorView.trailingAnchor),
            airlineHeadline.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constraints.topWithContentView)
        ])
    }

}
