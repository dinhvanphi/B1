//
//  Onboarding3ViewController.swift
//  B1
//
//  Created by Đinh Văn Phi on 11/3/26.
//

import UIKit
import GoogleMobileAds

class Onboarding3ViewController: UIViewController {

    // MARK: - Properties
    private var nativeAd: NativeAd?

    // MARK: - UI
    private let illustrationImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "onboarding3_image")
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.99, alpha: 1)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Without delay\nAnytime, Anywhere"
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
        pc.currentPage = 2  // ← trang 3
        pc.currentPageIndicatorTintColor = .systemBlue
        pc.pageIndicatorTintColor = .systemGray4
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()

    // MARK: - Native Ad View
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
        titleLabel.text = "without_delay".localized
        nextButton.setTitle("next_button".localized, for: .normal)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(illustrationImageView)
        view.addSubview(titleLabel)
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        view.addSubview(nativeAdView)
        setupNativeAdSubviews()

        NSLayoutConstraint.activate([
            // ảnh
            illustrationImageView.topAnchor.constraint(
                equalTo: view.topAnchor),
            illustrationImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            illustrationImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            illustrationImageView.heightAnchor.constraint(
                equalTo: view.heightAnchor, multiplier: 0.42),

            // title
            titleLabel.topAnchor.constraint(
                equalTo: illustrationImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -20),

            // next
            nextButton.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor, constant: 12),
            nextButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),

            // dots
            pageControl.topAnchor.constraint(
                equalTo: nextButton.bottomAnchor, constant: 8),
            pageControl.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),

            // native ad
            nativeAdView.topAnchor.constraint(
                equalTo: pageControl.bottomAnchor, constant: 12),
            nativeAdView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16),
            nativeAdView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -16),
            nativeAdView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])

        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }

    private func setupNativeAdSubviews() {
        nativeAdView.addSubview(adLabel)
        nativeAdView.addSubview(adIconImageView)
        nativeAdView.addSubview(adHeadlineLabel)
        nativeAdView.addSubview(adBodyLabel)
        nativeAdView.addSubview(installButton)

        nativeAdView.iconView         = adIconImageView
        nativeAdView.headlineView     = adHeadlineLabel
        nativeAdView.bodyView         = adBodyLabel
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
                guard let self,
                      let ad = NativeAdManager.shared.nativeAd else { return }

                self.nativeAdView.nativeAd  = ad
                self.adHeadlineLabel.text   = ad.headline
                self.adBodyLabel.text       = ad.body
                self.installButton.setTitle(ad.callToAction, for: .normal)

                if let icon = ad.icon {
                    self.adIconImageView.image = icon.image
                }
                print("✅ Onboarding3 Native Ad loaded")
            }
        }
    }

    // MARK: - Actions
    @objc private func nextTapped() {
        print("✅ Onboarding 3 → Finish")
        // TODO: Chuyển sang màn hình chính
    }
}
