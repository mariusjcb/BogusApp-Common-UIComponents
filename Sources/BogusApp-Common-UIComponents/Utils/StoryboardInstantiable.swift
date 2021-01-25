//
//  StoryboardInstantiable.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit

public class CommonUIComponentsResourceBundles {
    public static let shared = CommonUIComponentsResourceBundles()
    
    fileprivate var storyboardsBundle: Bundle?
    
    private init() { }
    
    public func setStoryboardsBundle(_ bundle: Bundle?) {
        self.storyboardsBundle = bundle
    }
}

public protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController() -> T
}

public extension StoryboardInstantiable where Self: UIViewController {
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static func instantiateViewController() -> Self {
        let fileName = defaultFileName
        let bundle = CommonUIComponentsResourceBundles.shared.storyboardsBundle
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return vc
    }
}
