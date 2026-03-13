//
//  Onboarding1ViewController.swift
//  B1
//
//  Created by Đinh Văn Phi on 11/3/26.
//

import Foundation
import UIKit
import GoogleMobileAds

class Onboarding1ViewController: UIViewController {

    // MARK: - Properties
    var onNextTapped: (() -> Void)?  // callback chuyển trang

    // MARK: - View 1: Top checkmark
    private let checkmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - View 2: Image
    private let illustrationImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "onboarding1_image") // ảnh trong Assets
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    // MARK: - View 3: Content
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to the world of languages"
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 3
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = .systemBlue
        pc.pageIndicatorTintColor = .systemGray4
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()

    // MARK: - View 4: Native Ad
    private var nativeAdView: NativeAdView = {
        let view = NativeAdView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let adLabel: UILabel = {
        let label = UILabel()
        label.text = "Ad"
        label.font = .systemFont(ofSize: 11)
        label.textColor = .white
        label.backgroundColor = .systemOrange
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let adIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let adHeadlineLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let adBodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let installButton: UIButton = {
        let button = UIButton()
        button.setTitle("INSTALL", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.94, green: 0.95, blue: 0.98, alpha: 1)
        setupUI()
        loadNativeAd()
//        setupSwipeGesture()
        
    }
    


    // MARK: - Setup UI
    private func setupUI() {
        // Thêm 4 view chính
        view.addSubview(checkmarkButton)
        view.addSubview(illustrationImageView)
        view.addSubview(titleLabel)
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        view.addSubview(nativeAdView)

        // Setup native ad subviews
        setupNativeAdView()

        NSLayoutConstraint.activate([

            // ✅ View 1: Checkmark góc trái
            checkmarkButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            checkmarkButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16),
            checkmarkButton.widthAnchor.constraint(equalToConstant: 30),
            checkmarkButton.heightAnchor.constraint(equalToConstant: 30),

            // ✅ View 2: Ảnh lớn
            illustrationImageView.topAnchor.constraint(
                equalTo: checkmarkButton.bottomAnchor, constant: 16),
            illustrationImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 20),
            illustrationImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -20),
            illustrationImageView.heightAnchor.constraint(
                equalTo: view.heightAnchor, multiplier: 0.35),

            // ✅ View 3: Title
            titleLabel.topAnchor.constraint(
                equalTo: illustrationImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -20),

            // Next button
            nextButton.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor, constant: 12),
            nextButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),

            // Page dots
            pageControl.topAnchor.constraint(
                equalTo: nextButton.bottomAnchor, constant: 8),
            pageControl.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),

            // ✅ View 4: Native Ad - dưới cùng
            nativeAdView.topAnchor.constraint(
                equalTo: pageControl.bottomAnchor, constant: 12),
            nativeAdView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16),
            nativeAdView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -16),
            nativeAdView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])

        // Actions
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        checkmarkButton.addTarget(self, action: #selector(checkmarkTapped), for: .touchUpInside)
    }

    // MARK: - Setup Native Ad View
    private func setupNativeAdView() {
        nativeAdView.addSubview(adLabel)
        nativeAdView.addSubview(adIconImageView)
        nativeAdView.addSubview(adHeadlineLabel)
        nativeAdView.addSubview(adBodyLabel)
        nativeAdView.addSubview(installButton)

        // Gán views cho NativeAdView
        nativeAdView.iconView       = adIconImageView
        nativeAdView.headlineView   = adHeadlineLabel
        nativeAdView.bodyView       = adBodyLabel
        nativeAdView.callToActionView = installButton

        NSLayoutConstraint.activate([
            adLabel.topAnchor.constraint(
                equalTo: nativeAdView.topAnchor, constant: 8),
            adLabel.leadingAnchor.constraint(
                equalTo: nativeAdView.leadingAnchor, constant: 8),
            adLabel.widthAnchor.constraint(equalToConstant: 24),
            adLabel.heightAnchor.constraint(equalToConstant: 16),

            adIconImageView.topAnchor.constraint(
                equalTo: nativeAdView.topAnchor, constant: 12),
            adIconImageView.leadingAnchor.constraint(
                equalTo: nativeAdView.leadingAnchor, constant: 12),
            adIconImageView.widthAnchor.constraint(equalToConstant: 44),
            adIconImageView.heightAnchor.constraint(equalToConstant: 44),

            adHeadlineLabel.topAnchor.constraint(
                equalTo: nativeAdView.topAnchor, constant: 12),
            adHeadlineLabel.leadingAnchor.constraint(
                equalTo: adIconImageView.trailingAnchor, constant: 10),
            adHeadlineLabel.trailingAnchor.constraint(
                equalTo: nativeAdView.trailingAnchor, constant: -12),

            adBodyLabel.topAnchor.constraint(
                equalTo: adHeadlineLabel.bottomAnchor, constant: 4),
            adBodyLabel.leadingAnchor.constraint(
                equalTo: adIconImageView.trailingAnchor, constant: 10),
            adBodyLabel.trailingAnchor.constraint(
                equalTo: nativeAdView.trailingAnchor, constant: -12),

            installButton.topAnchor.constraint(
                equalTo: adIconImageView.bottomAnchor, constant: 10),
            installButton.leadingAnchor.constraint(
                equalTo: nativeAdView.leadingAnchor, constant: 12),
            installButton.trailingAnchor.constraint(
                equalTo: nativeAdView.trailingAnchor, constant: -12),
            installButton.heightAnchor.constraint(equalToConstant: 44),
            installButton.bottomAnchor.constraint(
                equalTo: nativeAdView.bottomAnchor, constant: -12),
        ])
    }

    // MARK: - Load Native Ad
    private func loadNativeAd() {
        NativeAdManager.shared.loadAd()
        NativeAdManager.shared.onAdLoaded = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self,
                      let ad = NativeAdManager.shared.nativeAd else { return }

                self.nativeAdView.nativeAd    = ad
                self.adHeadlineLabel.text     = ad.headline
                self.adBodyLabel.text         = ad.body
                self.installButton.setTitle(ad.callToAction, for: .normal)

                if let icon = ad.icon {
                    self.adIconImageView.image = icon.image
                }
                print("✅ Native Ad loaded")
            }
        }
    }

    // MARK: - Actions
    @objc private func nextTapped() {
        print("✅ Next → Onboarding 2")
        onNextTapped?()  // callback chuyển trang
    }

    @objc private func checkmarkTapped() {
        print("✅ Checkmark tapped")
        // TODO: quay lại Language Screen
    }
}
