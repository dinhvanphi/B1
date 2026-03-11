import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("SplashViewController loaded")
        
        setupUI()
        InterstitialAdManager.shared.loadAd()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
          
            self.showInterstitialOrLanguage()
        }
    }

    // MARK: - UI
    private func setupUI() {
        view.backgroundColor = .white

        // Logo
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        logo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logo)

        // Tên app
        let label = UILabel()
        label.text = "AI Language Translator"
        label.textColor = .systemBlue
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        // Subtitle
        let subtitle = UILabel()
        subtitle.text = "This action may contain ads"
        subtitle.textColor = .lightGray
        subtitle.font = .systemFont(ofSize: 13)
        subtitle.textAlignment = .center
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitle)

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

            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 16),

            subtitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitle.bottomAnchor.constraint(equalTo: progress.topAnchor, constant: -8),

            progress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            progress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            progress.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
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

