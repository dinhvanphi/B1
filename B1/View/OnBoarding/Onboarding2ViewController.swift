//
//  Onboarding2ViewController.swift
//  B1
//
//  Created by Đinh Văn Phi on 11/3/26.
//

import UIKit

class Onboarding2ViewController: UIViewController {

    // MARK: - UI
    private let illustrationImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "onboarding2_image")
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.99, alpha: 1) // màu nền xanh nhạt
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Be precise with your language"
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 3
        pc.currentPage = 1  // ← trang 2
        pc.currentPageIndicatorTintColor = .systemBlue
        pc.pageIndicatorTintColor = .systemGray4
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        view.addSubview(illustrationImageView)
        view.addSubview(titleLabel)
        view.addSubview(pageControl)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            // ảnh chiếm phần lớn màn hình
            illustrationImageView.topAnchor.constraint(
                equalTo: view.topAnchor),
            illustrationImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            illustrationImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            illustrationImageView.heightAnchor.constraint(
                equalTo: view.heightAnchor, multiplier: 0.55),

            // title
            titleLabel.topAnchor.constraint(
                equalTo: illustrationImageView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -20),

            // page dots
            pageControl.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor, constant: 8),
            pageControl.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),

            // next button
            nextButton.topAnchor.constraint(
                equalTo: pageControl.bottomAnchor, constant: 6),
            nextButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
        ])

        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }

    @objc private func nextTapped() {
        print("✅ Onboarding 2 → Next")
    }
}
