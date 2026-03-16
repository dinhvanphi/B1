//
//  NativeFullViewController.swift
//  B1
//
//  Created by Đinh Văn Phi on 11/3/26.
//

import Foundation
import UIKit
import GoogleMobileAds

class NativeFullViewController: UIViewController {

    // MARK: - Properties
    var onDismissed: (() -> Void)?  

    // MARK: - UI
    private var nativeAdView: NativeAdView = {
        let view = NativeAdView()
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

    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let mediaView: MediaView = {
        let mv = MediaView()
        mv.contentMode = .scaleAspectFill
        mv.clipsToBounds = true
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
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
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let adBodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
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
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.94, green: 0.95, blue: 0.98, alpha: 1)
        setupUI()
        loadNativeAd()
        
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(nativeAdView)
        nativeAdView.addSubview(adLabel)
        nativeAdView.addSubview(closeButton)
        nativeAdView.addSubview(mediaView)
        nativeAdView.addSubview(adIconImageView)
        nativeAdView.addSubview(adHeadlineLabel)
        nativeAdView.addSubview(adBodyLabel)
        nativeAdView.addSubview(installButton)

        // Gán views cho NativeAdView
        nativeAdView.mediaView        = mediaView
        nativeAdView.iconView         = adIconImageView
        nativeAdView.headlineView     = adHeadlineLabel
        nativeAdView.bodyView         = adBodyLabel
        nativeAdView.callToActionView = installButton

        NSLayoutConstraint.activate([
            
            nativeAdView.topAnchor.constraint(equalTo: view.topAnchor),
            nativeAdView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            nativeAdView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nativeAdView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            
            adLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            adLabel.leadingAnchor.constraint(
                equalTo: nativeAdView.leadingAnchor, constant: 16),
            adLabel.widthAnchor.constraint(equalToConstant: 24),
            adLabel.heightAnchor.constraint(equalToConstant: 16),

            // Close button góc trên phải
            closeButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(
                equalTo: nativeAdView.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 36),
            closeButton.heightAnchor.constraint(equalToConstant: 36),

            // Media View - chiếm 45% màn hình
            mediaView.topAnchor.constraint(
                equalTo: adLabel.bottomAnchor, constant: 12),
            mediaView.leadingAnchor.constraint(
                equalTo: nativeAdView.leadingAnchor),
            mediaView.trailingAnchor.constraint(
                equalTo: nativeAdView.trailingAnchor),
            mediaView.heightAnchor.constraint(
                equalTo: view.heightAnchor, multiplier: 0.45),

            // Icon
            adIconImageView.topAnchor.constraint(
                equalTo: mediaView.bottomAnchor, constant: 16),
            adIconImageView.leadingAnchor.constraint(
                equalTo: nativeAdView.leadingAnchor, constant: 16),
            adIconImageView.widthAnchor.constraint(equalToConstant: 50),
            adIconImageView.heightAnchor.constraint(equalToConstant: 50),

            // Headline
            adHeadlineLabel.topAnchor.constraint(
                equalTo: mediaView.bottomAnchor, constant: 16),
            adHeadlineLabel.leadingAnchor.constraint(
                equalTo: adIconImageView.trailingAnchor, constant: 12),
            adHeadlineLabel.trailingAnchor.constraint(
                equalTo: nativeAdView.trailingAnchor, constant: -16),

            // Body
            adBodyLabel.topAnchor.constraint(
                equalTo: adHeadlineLabel.bottomAnchor, constant: 4),
            adBodyLabel.leadingAnchor.constraint(
                equalTo: adIconImageView.trailingAnchor, constant: 12),
            adBodyLabel.trailingAnchor.constraint(
                equalTo: nativeAdView.trailingAnchor, constant: -16),

            // Install button
            installButton.leadingAnchor.constraint(
                equalTo: nativeAdView.leadingAnchor, constant: 16),
            installButton.trailingAnchor.constraint(
                equalTo: nativeAdView.trailingAnchor, constant: -16),
            installButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            installButton.heightAnchor.constraint(equalToConstant: 52),
        ])

        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    }

    // MARK: - Swipe gesture

    // MARK: - Load Native Ad
    private func loadNativeAd() {
        NativeAdManager.shared.loadAd()
        NativeAdManager.shared.onAdLoaded = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self,
                      let ad = NativeAdManager.shared.nativeAd else { return }

                self.nativeAdView.nativeAd      = ad
                self.adHeadlineLabel.text       = ad.headline
                self.adBodyLabel.text           = ad.body
                self.mediaView.mediaContent     = ad.mediaContent
                self.installButton.setTitle(ad.callToAction, for: .normal)

                if let icon = ad.icon {
                    self.adIconImageView.image = icon.image
                }
                print(" Native Full Ad loaded")
            }
        }
    }

    // MARK: - Actions
    @objc private func closeTapped() {
        print(" Đóng Native Full")
       
    }



}
