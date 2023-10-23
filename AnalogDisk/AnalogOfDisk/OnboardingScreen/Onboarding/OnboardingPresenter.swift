//
//  OnboardingPresenter.swift
//  AnalogOfDisk
//
//  Created by Ольга on 18.10.2023.
//

import Foundation

protocol OnboardingPresenterProtocol {
    func setView(_ view: OnboardingViewProtocol)
    func getViewControllers()
    func getStartedScreen() -> PageViewController
    func getPageBefore(currentVC: PageViewController) -> PageViewController?
    func getPageAfter(currentVC: PageViewController) -> PageViewController?
    func isLastPage(currentVC: PageViewController)
}

class OnboardingPresenter {
    private var view: OnboardingViewProtocol?
    
    private var model: OnboardingModelProtocol
    init(model: OnboardingModelProtocol) {
        self.model = model
    }
}

extension OnboardingPresenter: OnboardingPresenterProtocol {
    func setView(_ view: OnboardingViewProtocol) {
        self.view = view
    }
    func getViewControllers() {
        model.getArrayPages()
    }
    func getStartedScreen() -> PageViewController {
        return model.getStartPage()
    }
    func getPageBefore(currentVC: PageViewController) -> PageViewController? {
        return model.getPageBefore(currentVC: currentVC)
    }
    func getPageAfter(currentVC: PageViewController) -> PageViewController? {
        return model.getPageAfter(currentVC: currentVC)
    }
    func isLastPage(currentVC: PageViewController) {
        guard let view = view else { return }
        view.onboardingIsFinish(isLastPage: model.lastPage(currentVC: currentVC))
    }
}
