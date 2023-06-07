//
//  EpisodeDetailsCoordinator.swift
//  EpisodeDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

import UIKit
import Core

public final class EpisodeDetailsCoordinator: Coordinator {

    public let rootViewController: UINavigationController
    public var episode: EpisodeDetailsModel.ViewObject?

    public init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    public func start(completion: (() -> Void)? = nil) {
        let controller = EpisodeDetailsViewController()
        controller.coordinator = self

        rootViewController.present(controller, animated: true)
    }
}
