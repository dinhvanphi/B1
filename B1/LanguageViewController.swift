//
//  LanguageViewController.swift
//  B1
//
//  Created by Đinh Văn Phi on 10/3/26.
//

import Foundation
import UIKit

struct Language {
    let flagImage: String
    let name: String
}

class LanguageViewController: UIViewController {

    // MARK: - Data
    let languages: [Language] = [
        Language(flagImage: "flag_Hindi", name: "Hindi"),
        Language(flagImage: "flag_Spanish", name: "Spanish"),
        Language(flagImage: "flag_French", name: "French"),
        Language(flagImage: "flag_English", name: "English"),
        Language(flagImage: "flag_Portuguese", name: "Portuguese"),
        Language(flagImage: "flag_Korean", name: "Korean"),
        Language(flagImage: "flag_Korean", name: "Korean"),
        
    ]
    
    var selectedIndex: Int = 0

    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Language"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupTableView()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(checkButton)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            // Title
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Check button
            checkButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            checkButton.widthAnchor.constraint(equalToConstant: 30),
            checkButton.heightAnchor.constraint(equalToConstant: 30),

            // TableView
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Setup TableView
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LanguageCell.self, forCellReuseIdentifier: "LanguageCell")
    }

    // MARK: - Actions
    @objc private func checkTapped() {
        let selected = languages[selectedIndex]
        print("Đã chọn: \(selected.name)")
        // TODO: Chuyển sang màn hình chính
    }
}

// MARK: - UITableViewDelegate & DataSource
extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "LanguageCell",
            for: indexPath) as! LanguageCell
        let language = languages[indexPath.row]
        
      
        cell.configure(
            flagImage: language.flagImage,
            name: language.name,
            isSelected: indexPath.row == selectedIndex
        )
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
        print(" Chọn: \(languages[indexPath.row].name)")
    }
}
