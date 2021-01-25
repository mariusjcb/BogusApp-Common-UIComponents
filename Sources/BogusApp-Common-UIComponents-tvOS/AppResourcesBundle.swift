//
//  File.swift
//  
//
//  Created by Marius Ilie on 24/01/2021.
//

import Foundation
import BogusApp_Common_UIComponents

public class AppResourcesBundle {
    public static func configure() {
        let bundle = Bundle.module
        bundle.load()
        CommonUIComponentsResourceBundles.shared.setStoryboardsBundle(bundle)
    }
}
