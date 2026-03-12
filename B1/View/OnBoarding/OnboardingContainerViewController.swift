//
//  OnboardingContainerViewController.swift
//  B1
//
//  Created by Đinh Văn Phi on 11/3/26.
//

import Foundation
import UIKit

class OnboardingContainerViewController: UIViewController {

    // MARK: - Properties
    private var pageViewController: UIPageViewController!
    
    // 4 màn hình theo thứ tự
    private lazy var pages: [UIViewController] = {
        let onboarding1 = Onboarding1ViewController()
        let nativeFull  = NativeFullViewController()
        let onboarding2 = Onboarding2ViewController()
        let onboarding3 = Onboarding3ViewController()
        return [onboarding1, nativeFull, onboarding2, onboarding3]
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
    }

    // MARK: - Setup
    private func setupPageViewController() {
        // Tạo PageViewController vuốt ngang
        pageViewController = UIPageViewController(
            transitionStyle: .scroll,       // ← vuốt ngang mượt
            navigationOrientation: .horizontal,
            options: nil)

        pageViewController.dataSource = self
        pageViewController.delegate   = self

        // Màn hình đầu tiên = Onboarding 1
        pageViewController.setViewControllers(
            [pages[0]],
            direction: .forward,
            animated: false)

        // Thêm vào container
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.didMove(toParent: self)

        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    // Vuốt phải → trang trước
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController),
              index > 0 else { return nil }
        return pages[index - 1]
    }

    // Vuốt trái → trang sau
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController),
              index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
}

// MARK: - UIPageViewControllerDelegate
extension OnboardingContainerViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed,
           let currentVC = pageViewController.viewControllers?.first,
           let index = pages.firstIndex(of: currentVC) {
            print("✅ Trang hiện tại: \(index)")
        }
    }
}
