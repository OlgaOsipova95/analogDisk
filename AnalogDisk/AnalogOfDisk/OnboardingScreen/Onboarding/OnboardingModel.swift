//
//  OnboardingModel.swift
//  AnalogOfDisk
//
//  Created by Ольга on 18.10.2023.
//

import Foundation

protocol OnboardingModelProtocol {
    func getArrayPages()
    func getStartPage() -> PageViewController
    func getPageBefore(currentVC: PageViewController) -> PageViewController?
    func getPageAfter(currentVC: PageViewController) -> PageViewController?
    func lastPage(currentVC: PageViewController) -> Bool
}

class OnboardingModel {
    private let dataForPages = PagesOnboarding().data
    var pagesArray = [PageViewController]()
}

extension OnboardingModel: OnboardingModelProtocol {
    func getArrayPages() {
        for (index, page) in dataForPages.enumerated() {
            let model = PageModel(nameImage: page.image , description: page.description, index: index)
            let presenter = PagePresenter(model: model)
            let pageVC = PageViewController()
            pageVC.presenter = presenter
            pagesArray.append(pageVC)
        }
    }
    
    func getStartPage() -> PageViewController {
        return pagesArray[0]
    }
    func getPageBefore(currentVC: PageViewController) -> PageViewController? {
        let index = pagesArray.firstIndex(of: currentVC) ?? 0
        guard index > 0 else { return nil }
        return pagesArray[index - 1]
    }
    func getPageAfter(currentVC: PageViewController) -> PageViewController? {
        let index = pagesArray.firstIndex(of: currentVC) ?? 0
        guard index < pagesArray.count - 1 else { return nil }
        return pagesArray[index+1]
    }
    func lastPage(currentVC: PageViewController) -> Bool {
        let index = pagesArray.firstIndex(of: currentVC)
        return index == pagesArray.count - 1
    }
}
