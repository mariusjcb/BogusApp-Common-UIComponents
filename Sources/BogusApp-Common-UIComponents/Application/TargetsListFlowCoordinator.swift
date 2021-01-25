//
//  TargetsListFlowCoordinator.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit
import BogusApp_Common_Models
import BogusApp_Features_TargetsList
import BogusApp_Features_ChannelsList
import BogusApp_Features_PlansList
import BogusApp_Features_CampaignReview

#if !os(tvOS)
import MessageUI
#endif

public protocol TargetsListFlowCoordinatorDependencies {
    func makeTargetsListViewController(actions: TargetsListViewModelActions) -> TargetsListViewController
    func makeChannelsListViewController(for targets: [TargetSpecific], actions: ChannelsListViewModelActions) -> ChannelsListViewController
    func makePlansListViewController(for channel: Channel, plans: [Plan], didSelect: @escaping (Int) -> Void) -> PlansListViewController
    func makeCampaignReviewViewController(for targets: [TargetSpecific],
                                          selectedPlans: [(Channel, Int)],
                                          actions: CampaignReviewViewModelActions) -> CampaignReviewViewController
}

public final class TargetsListFlowCoordinator: NSObject {
    
    public private(set) weak var navigationController: UINavigationController?
    private let dependencies: TargetsListFlowCoordinatorDependencies
    
    private weak var targetsListController: TargetsListViewController?
    
    init(navigationController: UINavigationController, dependencies: TargetsListFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func start() {
        let actions = TargetsListViewModelActions(showChannelsForSelectedTarget: showChannelsForSelectedTarget)
        let vc = dependencies.makeTargetsListViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
        targetsListController = vc
    }

    private func showChannelsForSelectedTarget(_ targets: [TargetSpecific]) {
        let actions = ChannelsListViewModelActions(showPlansSelector: showPlansSelector, showCampaignReview: showCampaignReview)
        let vc = dependencies.makeChannelsListViewController(for: targets, actions: actions)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showPlansSelector(_ channel: Channel, _ plans: [Plan], _ didSelect: @escaping (Int) -> Void) {
        let vc = dependencies.makePlansListViewController(for: channel, plans: plans, didSelect: didSelect)
        vc.viewModel.didSelect = { index in
            didSelect(index)
            vc.dismiss(animated: true)
        }
        navigationController?.present(vc, animated: true)
    }
    
    private func showCampaignReview(_ targets: [TargetSpecific], selectedPlans: [(Channel, Int)]) {
        let actions = CampaignReviewViewModelActions(sendEmail: sendEmail)
        let vc = dependencies.makeCampaignReviewViewController(for: targets, selectedPlans: selectedPlans, actions: actions)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    public func sendEmail(_ toEmail: String, _ message: String) {
        #if !os(tvOS)
        composeMail(to: toEmail, message: message)
        #else
        // A solution to send emails could be MultipeerConnectivity
        navigationController?.showAlert(title: NSLocalizedString("Unable to send emails from this device", comment: ""),
                                        message: message,
                                        preferredStyle: .alert)
        #endif
    }
    
    #if !os(tvOS)
    private func composeMail(to: String, message: String) {
        DispatchQueue.main.async {
            guard MFMailComposeViewController.canSendMail() else {
                self.navigationController?.showAlert(title: NSLocalizedString("Unable to send emails from this device", comment: ""),
                                                     message: message,
                                                     preferredStyle: .alert)
                return
            }
            let mail = MFMailComposeViewController()
            guard let delegate = mail as? MFMailComposeViewControllerDelegate else { return }
            mail.mailComposeDelegate = delegate
            mail.setToRecipients([to])
            mail.setMessageBody(message, isHTML: false)
            
            self.navigationController?.present(mail, animated: true)
        }
    }
    #endif
}
