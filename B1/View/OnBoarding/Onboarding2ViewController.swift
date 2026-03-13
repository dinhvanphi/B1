import UIKit

class Onboarding2ViewController: UIViewController {

    // MARK: - UI
    private let illustrationImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "onboarding2_image")
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = UIColor(red: 0.94, green: 0.95, blue: 0.98, alpha: 1)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Be precise with your language"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // ✅ Custom page indicator
    private let pageIndicator: CustomPageIndicator = {
        let indicator = CustomPageIndicator(numberOfPages: 3, currentPage: 1)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.94, green: 0.95, blue: 0.98, alpha: 1)
        setupUI()
        titleLabel.text = "be_precise".localized
        nextButton.setTitle("next_button".localized, for: .normal)
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(illustrationImageView)
        view.addSubview(titleLabel)
        view.addSubview(nextButton)
        view.addSubview(pageIndicator)

        NSLayoutConstraint.activate([

            // ✅ Ảnh chiếm 70% màn hình
            illustrationImageView.topAnchor.constraint(
                equalTo: view.topAnchor),
            illustrationImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            illustrationImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            illustrationImageView.heightAnchor.constraint(
                equalTo: view.heightAnchor, multiplier: 0.70),

            // ✅ Page indicator neo dưới cùng
            pageIndicator.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            pageIndicator.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            pageIndicator.heightAnchor.constraint(equalToConstant: 8),

            // ✅ Next button ngay trên dots
            nextButton.bottomAnchor.constraint(
                equalTo: pageIndicator.topAnchor, constant: -10),
            nextButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),

            // ✅ Title ngay trên Next button
            titleLabel.bottomAnchor.constraint(
                equalTo: nextButton.topAnchor, constant: -12),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -32),
        ])

        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }

    // MARK: - Public
    func updatePageIndicator(_ page: Int) {
        pageIndicator.setCurrentPage(page, animated: true)
    }

    // MARK: - Actions
    @objc private func nextTapped() {
        print("✅ Onboarding 2 → Next")
    }
}
