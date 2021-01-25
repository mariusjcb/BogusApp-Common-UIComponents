//
//  AppDIContainer.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import Foundation
import BogusApp_Common_Networking

public final class AppDIContainer {

    lazy var appConfiguration = AppConfiguration()

    public init() { }

    // MARK: - Network
    lazy var dataTransferService: NetworkService = {
        let config = DefaultNetworkConfiguration(baseURL: URL(string: appConfiguration.baseURL)!)
        return DefaultNetworkService(config: config)
    }()

    // MARK: - DIContainers of scenes
    public func makeTargetsSceneDIContainer() -> TargetsSceneDIContainer {
        let dependencies = TargetsSceneDIContainer.Dependencies(networkService: dataTransferService)
        return TargetsSceneDIContainer(dependencies: dependencies)
    }
}
