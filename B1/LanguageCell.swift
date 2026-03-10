//
//  LanguageCell.swift
//  B1
//
//  Created by Đinh Văn Phi on 10/3/26.
//

import Foundation
import UIKit

class LanguageCell: UITableViewCell {
    
    private let flagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(flagLabel)
        containerView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            flagLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            flagLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: flagLabel.trailingAnchor, constant: 12),
            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    func configure(flag: String, name: String, isSelected: Bool) {
        flagLabel.text = flag
        nameLabel.text = name
        
        // Highlight khi được chọn
        if isSelected {
            containerView.layer.borderColor = UIColor.systemBlue.cgColor
            containerView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.05)
            nameLabel.textColor = .systemBlue
            nameLabel.font = .boldSystemFont(ofSize: 17)
        } else {
            containerView.layer.borderColor = UIColor.systemGray5.cgColor
            containerView.backgroundColor = .white
            nameLabel.textColor = .black
            nameLabel.font = .systemFont(ofSize: 17)
        }
    }
}
