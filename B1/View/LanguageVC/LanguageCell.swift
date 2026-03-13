import UIKit

class LanguageCell: UITableViewCell {

    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(flagImageView)
        containerView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            //  Flag image size
            flagImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            flagImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            flagImageView.widthAnchor.constraint(equalToConstant: 36),
            flagImageView.heightAnchor.constraint(equalToConstant: 36),

            nameLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 12),
            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }

    // ✅ Nhận flagImage là tên ảnh trong Assets
    func configure(flagImage: String, name: String, isSelected: Bool) {
        flagImageView.image = UIImage(named: flagImage)
        nameLabel.text = name

        if isSelected {
            containerView.layer.borderColor = UIColor.systemBlue.cgColor
            containerView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.05)
            nameLabel.textColor = .systemBlue
            nameLabel.font = .boldSystemFont(ofSize: 17)
        } else {
            containerView.layer.borderColor = UIColor.systemGray5.cgColor
            containerView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.99, alpha: 1)
            
            nameLabel.textColor = .black
            nameLabel.font = .systemFont(ofSize: 17)
        }
    }
}

