//
//  ActionSheet+Presenter.swift
//  Sheeeeeeeeet
//
//  Created by Daniel Saidi on 2018-04-27.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

public extension ActionSheet {
    
    /**
     Get the default presenter. It will be used if you don't
     specify a specific presenter when presenting the sheet.
     */
    static func defaultPresenter(
        for viewController: UIViewController) -> ActionSheetPresenter {
        let traits = viewController.traitCollection
        return defaultPresenter(forTraits: traits)
    }
}

extension ActionSheet {
    
    static func defaultPresenter(
        for device: UIDevice = .current,
        forTraits traits: UITraitCollection?) -> ActionSheetPresenter {
        let idiom = traits?.userInterfaceIdiom ?? device.userInterfaceIdiom
        return defaultPresenter(forIdiom: idiom, traits: traits)
    }
    
    static func defaultPresenter(
        forIdiom idiom: UIUserInterfaceIdiom,
        traits: UITraitCollection?) -> ActionSheetPresenter {
        if idiom == .phone { return ActionSheetStandardPresenter() }
        let sizeClass = traits?.horizontalSizeClass ?? .compact
        let isCompact = sizeClass == .compact
        return isCompact ? ActionSheetStandardPresenter() : ActionSheetPopoverPresenter()
    }
}
