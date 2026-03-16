import UIKit

class SplashViewController: UIViewController {

    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.94, green: 0.95, blue: 0.98, alpha: 1)
        setupUI()

       
        titleLabel.text    = "splash_title".localized
        subtitleLabel.text = "sub_title".localized

        InterstitialAdManager.shared.loadAd()

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.showInterstitialOrLanguage()
        }
    }

    // MARK: - UI
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.94, green: 0.95, blue: 0.98, alpha: 1)

        // Logo
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        logo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logo)

        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)

        // Progress bar
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progress = 1.0
        progress.tintColor = .systemBlue
        progress.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progress)

        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            logo.widthAnchor.constraint(equalToConstant: 120),
            logo.heightAnchor.constraint(equalToConstant: 120),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 16),

            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: progress.topAnchor, constant: -8),

            progress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            progress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            progress.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }

    // MARK: - Chuyển màn hình
    private func showInterstitialOrLanguage() {
        if InterstitialAdManager.shared.isAdReady {
            print(" Ad sẵn sàng")
            InterstitialAdManager.shared.showAd(from: self) {
                self.goToLanguageScreen()
            }
        } else {
            print(" Ad chưa sẵn sàng")
            goToLanguageScreen()
        }
    }

    private func goToLanguageScreen() {
        print(" Chuyển Language Screen")

        let storyboard = UIStoryboard(name: "Language", bundle: nil)
        guard let langVC = storyboard.instantiateInitialViewController() else {
            print(" Không tìm thấy Language storyboard")
            return
        }
        guard let window = self.view.window else { return }

        window.rootViewController = langVC
        UIView.transition(
            with: window,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: nil
        )
    }
}
