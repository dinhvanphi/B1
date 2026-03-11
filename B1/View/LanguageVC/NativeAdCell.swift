import UIKit
import GoogleMobileAds

class NativeAdCell: UITableViewCell {
    
    // MARK: - UI Components
    private let adView: NativeAdView = {
        let view = NativeAdView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let headlineLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mediaView: MediaView = {
        let mv = MediaView()
        mv.contentMode = .scaleAspectFill
        mv.clipsToBounds = true
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
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
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(adView)
        adView.addSubview(adLabel)
        adView.addSubview(iconImageView)
        adView.addSubview(headlineLabel)
        adView.addSubview(bodyLabel)
        adView.addSubview(mediaView)
        adView.addSubview(installButton)
        
        NSLayoutConstraint.activate([
            // AdView
            adView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            adView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            adView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            adView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Ad label
            adLabel.topAnchor.constraint(equalTo: adView.topAnchor, constant: 8),
            adLabel.leadingAnchor.constraint(equalTo: adView.leadingAnchor, constant: 8),
            adLabel.widthAnchor.constraint(equalToConstant: 24),
            adLabel.heightAnchor.constraint(equalToConstant: 16),
            
            // Icon
            iconImageView.topAnchor.constraint(equalTo: adView.topAnchor, constant: 12),
            iconImageView.leadingAnchor.constraint(equalTo: adView.leadingAnchor, constant: 12),
            iconImageView.widthAnchor.constraint(equalToConstant: 44),
            iconImageView.heightAnchor.constraint(equalToConstant: 44),
            
            // Headline
            headlineLabel.topAnchor.constraint(equalTo: adView.topAnchor, constant: 12),
            headlineLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            headlineLabel.trailingAnchor.constraint(equalTo: adView.trailingAnchor, constant: -12),
            
            // Body
            bodyLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 4),
            bodyLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            bodyLabel.trailingAnchor.constraint(equalTo: adView.trailingAnchor, constant: -12),
            
            // Media
            mediaView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10),
            mediaView.leadingAnchor.constraint(equalTo: adView.leadingAnchor),
            mediaView.trailingAnchor.constraint(equalTo: adView.trailingAnchor),
            mediaView.heightAnchor.constraint(equalToConstant: 160),
            
            // Install button
            installButton.topAnchor.constraint(equalTo: mediaView.bottomAnchor, constant: 10),
            installButton.leadingAnchor.constraint(equalTo: adView.leadingAnchor, constant: 12),
            installButton.trailingAnchor.constraint(equalTo: adView.trailingAnchor, constant: -12),
            installButton.heightAnchor.constraint(equalToConstant: 44),
            installButton.bottomAnchor.constraint(equalTo: adView.bottomAnchor, constant: -12)
        ])
        
        // Gán views cho NativeAdView
        adView.iconView = iconImageView
        adView.headlineView = headlineLabel
        adView.bodyView = bodyLabel
        adView.mediaView = mediaView
        adView.callToActionView = installButton
    }
    
    // MARK: - Configure với NativeAd
    func configure(with nativeAd: NativeAd) {
        adView.nativeAd = nativeAd
        
        headlineLabel.text = nativeAd.headline
        bodyLabel.text = nativeAd.body
        (adView.callToActionView as? UIButton)?.setTitle(
            nativeAd.callToAction, for: .normal)
        
        if let icon = nativeAd.icon {
            iconImageView.image = icon.image
        }
        
        adView.mediaView?.mediaContent = nativeAd.mediaContent
    }
}
