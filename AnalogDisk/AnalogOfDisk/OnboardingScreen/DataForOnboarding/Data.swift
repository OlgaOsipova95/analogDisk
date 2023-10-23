//
//  Data.swift
//  AnalogOfDisk
//
//  Created by Ольга on 18.10.2023.
//

import Foundation

struct DataForOnboarding {
    let image: String
    let description: String
}

struct PagesOnboarding {
    let data: [DataForOnboarding] = [
    DataForOnboarding(image: "page_1", description: NSLocalizedString("onboarding.page_1", comment: "")),
    DataForOnboarding(image: "page_2", description: NSLocalizedString("onboarding.page_2", comment: "")),
    DataForOnboarding(image: "page_3", description: NSLocalizedString("onboarding.page_3", comment: ""))
    ]
}
