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
    lazy var dataTransferService: DataTransferService = {
        let config = DefaultNetworkConfiguration(baseURL: URL(string: appConfiguration.baseURL)!)
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    
    // MARK: - DIContainers of scenes
    public func makeTargetsSceneDIContainer() -> TargetsSceneDIContainer {
        let dependencies = TargetsSceneDIContainer.Dependencies(apiDataTransferService: dataTransferService)
        return TargetsSceneDIContainer(dependencies: dependencies)
    }
}
