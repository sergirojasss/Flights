//
//  ShimmerCell.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 21/2/22.
//

import UIKit


// MARK: - Constants

extension ShimmerCell {
    private enum Constants {
        static let shadowOpacity = Float(0.2)
        static let shadowOffset = CGSize(width: 1, height: 4)
        static let shadowRadius = CGFloat(5.0)
        static let cornerRadius = 6.0
    }

    private enum Colours {
        static let shimmerColor = UIColor.gray.withAlphaComponent(0.2)
    }
}

final class ShimmerCell: UITableViewCell, ReusableCell {

    private var containerView: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = .gray.withAlphaComponent(0.2)
        containerView.layer.cornerRadius = Constants.cornerRadius
        return containerView
    }()

    private func setupView() {
        contentView.addSubview(containerView)
        setupConstraints()
    }
}

extension ShimmerCell {
    //MARK: - Public methods
    func configure() {
        containerView.addShimmer(withCornerRadius: Constants.cornerRadius,
                           withBackgroundColor: Colours.shimmerColor)
        
        DispatchQueue.main.async {
            self.containerView.startShining()
        }
        
        setupView()
        layoutIfNeeded()
    }

}

extension ShimmerCell {
    private enum Constraints {
        static let leadingWithContentView = 20.0
        static let trailingWithContentView = 20.0
        static let spacingCells = 5.0
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraints.spacingCells),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraints.leadingWithContentView),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraints.trailingWithContentView),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraints.spacingCells),
            
            containerView.heightAnchor.constraint(equalToConstant: 220.0)
        ])
    }

}
