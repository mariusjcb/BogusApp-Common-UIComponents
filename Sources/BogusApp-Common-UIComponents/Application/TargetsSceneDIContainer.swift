//
//  TargetsSceneDIContainer.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit
import BogusApp_Common_Models
import BogusApp_Common_Networking
import BogusApp_Features_TargetsList
import BogusApp_Features_ChannelsList
import BogusApp_Features_PlansList
import BogusApp_Features_CampaignReview

public final class TargetsSceneDIContainer {

    struct Dependencies {
        let networkService: NetworkService
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Use Cases
    func makeFetchTargetsListUseCase() -> FetchTargetsListUseCase {
        return DefaultFetchTargetsListUseCase(targetsRepository: makeTargetsRepository())
    }

    // MARK: - Repositories
    func makeTargetsRepository() -> TargetsRepository {
        return DefaultTargetsRepository(targetsService: dependencies.networkService,
                                        endpointsProvider: DefaultTargetsEndpointProvider())
    }

    // MARK: - Targets List
    public func makeTargetsListViewController(actions: TargetsListViewModelActions) -> TargetsListViewController {
        return TargetsListViewController.create(with: makeTargetsListViewModel(actions: actions))
    }

    func makeTargetsListViewModel(actions: TargetsListViewModelActions) -> TargetsListViewModel {
        return DefaultTargetsListViewModel(fetchTargetsListUseCase: makeFetchTargetsListUseCase(), actions: actions)
    }

    public func makeChannelsListViewController(for targets: [TargetSpecific],
                                        actions: ChannelsListViewModelActions) -> ChannelsListViewController {
        return ChannelsListViewController.create(with: makeChannelsListViewModel(for: targets, actions: actions))
    }

    func makeChannelsListViewModel(for targets: [TargetSpecific], actions: ChannelsListViewModelActions) -> ChannelsListViewModel {
        return DefaultChannelsListViewModel(targets: targets, actions: actions)
    }

    public func makePlansListViewController(for channel: Channel, plans: [Plan], didSelect: @escaping (Int) -> Void) -> PlansListViewController {
        return PlansListViewController.create(with: makePlansListViewModel(for: channel, plans: plans, didSelect: didSelect))
    }

    func makePlansListViewModel(for channel: Channel, plans: [Plan], didSelect: @escaping (Int) -> Void) -> PlansListViewModel {
        return DefaultPlansListViewModel(for: channel, plans: plans, didSelect: didSelect)
    }

    public func makeCampaignReviewViewController(for targets: [TargetSpecific],
                                          selectedPlans: [(Channel, Int)],
                                          actions: CampaignReviewViewModelActions) -> CampaignReviewViewController {
        return CampaignReviewViewController.create(with: makeCampaignReviewViewModel(for: targets,
                                                                                     selectedPlans: selectedPlans,
                                                                                     actions: actions))
    }

    func makeCampaignReviewViewModel(for targets: [TargetSpecific],
                                     selectedPlans: [(Channel, Int)],
                                     actions: CampaignReviewViewModelActions) -> CampaignReviewViewModel {
        return DefaultCampaignReviewViewModel(targets: targets, selectedPlans: selectedPlans, actions: actions)
    }

    // MARK: - Flow Coordinators
    public func makeTargetsListFlowCoordinator(navigationController: UINavigationController) -> TargetsListFlowCoordinator {
        return TargetsListFlowCoordinator(navigationController: navigationController, dependencies: self)
    }

}

extension TargetsSceneDIContainer: TargetsListFlowCoordinatorDependencies {}
