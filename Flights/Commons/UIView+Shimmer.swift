//
//  UIView+Shimmer.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 21/2/22.
//

import Foundation
import UIKit

final class Shimmer: UIView {}

public extension UIView {
    private enum Constants {
        static let shiningLocations: [NSNumber] = [0, 0.2, 0.4, 0.6, 0.8, 1]
    }

    func addShimmer(withCornerRadius cornerRadius: CGFloat = 8.0, withBackgroundColor backgroundColor: UIColor) {
        removeShimmer()
        let shimmerView = Shimmer()
        shimmerView.backgroundColor = backgroundColor
        addSubview(shimmerView)
        if cornerRadius != 0.0 {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
        equalEdges(to: shimmerView)
    }

    func removeShimmer() {
        guard let view = subviews.first(where: { $0 is Shimmer }),
              let shimmerView = view as? Shimmer
        else { return }

        shimmerView.removeFromSuperview()
    }

    func startShining(color: UIColor = .white) {
        stopShining()
        animate(view: self, start: true, color: color)
    }

    func stopShining() {
        animate(view: self, start: false, color: .white)
    }

    private func animate(view: UIView, start: Bool, color: UIColor) {
        if start {
            let colorLayer = CALayer()
            colorLayer.backgroundColor = UIColor.clear.cgColor
            colorLayer.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: view.bounds.height))
            colorLayer.name = "colorLayer"
            view.layer.addSublayer(colorLayer)
            view.autoresizesSubviews = true
            view.clipsToBounds = true

            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [color.withAlphaComponent(0.1).cgColor,
                                    color.withAlphaComponent(0.5).cgColor,
                                    color.withAlphaComponent(0.8).cgColor,
                                    color.withAlphaComponent(0.5).cgColor,
                                    color.withAlphaComponent(0.1).cgColor]

            gradientLayer.locations = Constants.shiningLocations
            gradientLayer.name = "loaderLayer"
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: view.bounds.height))
            view.layer.addSublayer(gradientLayer)

            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.duration = 1.2
            animation.fromValue = -view.frame.width
            animation.toValue = view.frame.width
            animation.repeatCount = .infinity
            gradientLayer.add(animation, forKey: "smartLoader")
        } else {
            guard let smartLayers = view.layer.sublayers?.filter({ $0.name == "colorLayer" || $0.name == "loaderLayer" }) else { return }

            smartLayers.forEach { $0.removeFromSuperlayer() }
        }
    }

    internal func equalEdges(to targetView: UIView) {
        targetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            targetView.leadingAnchor.constraint(equalTo: leadingAnchor),
            targetView.trailingAnchor.constraint(equalTo: trailingAnchor),
            targetView.topAnchor.constraint(equalTo: topAnchor),
            targetView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        layoutIfNeeded()
    }
}
