//
//  OnboardingViewController.swift
//  AnalogOfDisk
//
//  Created by Ольга on 18.10.2023.
//

import Foundation
import UIKit
import SnapKit

protocol OnboardingViewProtocol {
    func clickButton()
    func onboardingIsFinish(isLastPage: Bool)
    var didFinish: (()->Void)? { get set }
}

class OnboardingViewController: UIPageViewController {
    
    private var presenter = OnboardingPresenter(model: OnboardingModel())
    private var settingStorage = SettingStorage()
    var didFinish: (()->Void)?
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(red: 0.22, green: 0.247, blue: 0.961, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(NSLocalizedString("onboarding.next_button", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        presenter.setView(self)
        setupConstraints()
        presenter.getViewControllers()
        setViewControllers([presenter.getStartedScreen()], direction: .forward, animated: false, completion: nil)
    }
}

extension OnboardingViewController: OnboardingViewProtocol {
    @objc func clickButton() {
        presenter.isLastPage(currentVC: self.viewControllers?.first as! PageViewController)
    }
    func onboardingIsFinish(isLastPage: Bool) {
        if isLastPage {
            settingStorage.onboardingWasShown = true
            didFinish?()
        }
        guard let currentVC = viewControllers?.first,
              let nextVC = dataSource?.pageViewController(self, viewControllerAfter: currentVC)
        else { return }
        setViewControllers([nextVC], direction: .forward, animated: false, completion: nil)
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return presenter.getPageBefore(currentVC: (self.viewControllers?.first as! PageViewController))
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return presenter.getPageAfter(currentVC: (self.viewControllers?.first as! PageViewController))
    }
}

extension OnboardingViewController {
    func setupConstraints() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-92)
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
    }
}
