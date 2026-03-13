//
//  CustomPageIndicator.swift
//  B1
//
//  Created by Đinh Văn Phi on 12/3/26.
//

import Foundation
import UIKit

class CustomPageIndicator: UIView {

    // MARK: - Properties
    private var numberOfPages: Int
    private var currentPage: Int
    private var dotViews: [UIView] = []

    private let dotHeight: CGFloat = 8
    private let dotWidth: CGFloat = 8
    private let activeDotWidth: CGFloat = 24
    private let dotSpacing: CGFloat = 6
    private let dotColor = UIColor.systemGray4
    private let activeDotColor = UIColor.systemBlue

    // MARK: - Init
    init(numberOfPages: Int, currentPage: Int = 0) {
        self.numberOfPages = numberOfPages
        self.currentPage = currentPage
        super.init(frame: .zero)
        setupDots()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Setup
    private func setupDots() {
        dotViews.forEach { $0.removeFromSuperview() }
        dotViews = []

        for _ in 0..<numberOfPages {
            let dot = UIView()
            dot.translatesAutoresizingMaskIntoConstraints = false
            addSubview(dot)
            dotViews.append(dot)
        }
        layoutDots()
    }

    private func layoutDots() {
        var previousDot: UIView? = nil

        for (i, dot) in dotViews.enumerated() {
            let isActive = i == currentPage
            let width = isActive ? activeDotWidth : dotWidth

            dot.backgroundColor = isActive ? activeDotColor : dotColor
            dot.layer.cornerRadius = dotHeight / 2

            NSLayoutConstraint.activate([
                dot.centerYAnchor.constraint(equalTo: centerYAnchor),
                dot.heightAnchor.constraint(equalToConstant: dotHeight),
                dot.widthAnchor.constraint(equalToConstant: width),
            ])

            if let prev = previousDot {
                dot.leadingAnchor.constraint(
                    equalTo: prev.trailingAnchor,
                    constant: dotSpacing).isActive = true
            } else {
                dot.leadingAnchor.constraint(
                    equalTo: leadingAnchor).isActive = true
            }

            if i == dotViews.count - 1 {
                dot.trailingAnchor.constraint(
                    equalTo: trailingAnchor).isActive = true
            }

            previousDot = dot
        }
    }

    // MARK: - Public
    func setCurrentPage(_ page: Int, animated: Bool = true) {
        currentPage = page

        if animated {
            UIView.animate(withDuration: 0.3) {
                self.updateColors()
                self.layoutIfNeeded()
            }
        } else {
            updateColors()
        }
    }

    private func updateColors() {
        for (i, dot) in dotViews.enumerated() {
            dot.backgroundColor = i == currentPage ? activeDotColor : dotColor
        }
    }
}
