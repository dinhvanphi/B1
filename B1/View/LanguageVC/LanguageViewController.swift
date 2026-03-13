import Foundation
import UIKit
import GoogleMobileAds

struct Language {
    let flagImage: String
    let name: String
}

// MARK: - Section
enum Section: Int, CaseIterable {
    case languages
    case nativeAd
}

class LanguageViewController: UIViewController {

    // MARK: - Data
    let languages: [Language] = [
        Language(flagImage: "flag_Hindi",      name: "Hindi"),
        Language(flagImage: "flag_Spanish",    name: "Spanish"),
        Language(flagImage: "flag_French",     name: "French"),
        Language(flagImage: "flag_English",    name: "English"),
        Language(flagImage: "flag_Portuguese", name: "Portuguese"),
        Language(flagImage: "flag_Korean",     name: "Korean"),
    ]

    var selectedIndex: Int = 0
    var nativeAd: NativeAd?  // ← thêm

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
        table.backgroundColor = UIColor(red: 0.94, green: 0.95, blue: 0.98, alpha: 1)
        return table
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.94, green: 0.95, blue: 0.98, alpha: 1)
        tableView.backgroundColor = UIColor(red: 0.94, green: 0.95, blue: 0.98, alpha: 1)
        setupUI()
        setupTableView()
        loadNativeAd()  // ← thêm
    }

    // MARK: - Load Native Ad
    private func loadNativeAd() {
        NativeAdManager.shared.loadAd()
        NativeAdManager.shared.onAdLoaded = { [weak self] in
            DispatchQueue.main.async {
                self?.nativeAd = NativeAdManager.shared.nativeAd
                self?.tableView.reloadSections(
                    IndexSet(integer: Section.nativeAd.rawValue),
                    with: .automatic)
                print("✅ Native Ad hiển thị")
            }
        }
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(checkButton)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            checkButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            checkButton.widthAnchor.constraint(equalToConstant: 30),
            checkButton.heightAnchor.constraint(equalToConstant: 30),

            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        checkButton.addTarget(self, action: #selector(checkTapped), for: .touchUpInside)
    }

    // MARK: - Setup TableView
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LanguageCell.self,
                           forCellReuseIdentifier: "LanguageCell")
        tableView.register(NativeAdCell.self,
                           forCellReuseIdentifier: "NativeAdCell")  // ← thêm
    }

    // MARK: - Actions
    @objc private func checkTapped() {
        let selected = languages[selectedIndex]
        print("✅ Đã chọn: \(selected.name)")

        // ✅ Chuyển sang Container (chứa 4 trang)
        let container = OnboardingContainerViewController()

        guard let window = self.view.window else { return }
        window.rootViewController = container
        UIView.transition(
            with: window,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: nil
        )
    }
}

// MARK: - UITableViewDelegate & DataSource
extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {

    // ✅ 2 sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .languages: return languages.count
        case .nativeAd:  return nativeAd != nil ? 1 : 0
        default:         return 0
        }
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Section(rawValue: indexPath.section) {
        case .languages: return 64
        case .nativeAd:  return 300
        default:         return 0
        }
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section) {

        case .languages:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "LanguageCell",
                for: indexPath) as! LanguageCell
            let language = languages[indexPath.row]
            cell.configure(
                flagImage: language.flagImage,
                name: language.name,
                isSelected: indexPath.row == selectedIndex)
            return cell

        case .nativeAd:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "NativeAdCell",
                for: indexPath) as! NativeAdCell
            if let ad = nativeAd {
                cell.configure(with: ad)
            }
            return cell

        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        // Chỉ xử lý tap ở section languages
        guard Section(rawValue: indexPath.section) == .languages else { return }
        selectedIndex = indexPath.row
        tableView.reloadData()
        print("Chọn: \(languages[indexPath.row].name)")
    }
}
