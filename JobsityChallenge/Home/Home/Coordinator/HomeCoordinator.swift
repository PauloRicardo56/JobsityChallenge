//
//  HomeCoordinator.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit
import Core
import ShowDetails

public final class HomeCoordinator: Coordinator {

    public let rootViewController: UINavigationController

    public init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    public func start(completion: (() -> Void)? = nil) {
        let controller = HomeViewController()
        let interactor = DefaultHomeInteractor()
        let presenter = DefaultHomePresenter()
        controller.coordinator = self
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller

        rootViewController.pushViewController(controller, animated: true)
    }

    func homeCoordinator(showDetailsOfShow show: Show.ViewObject) {
        let showDetailsCoordinator = ShowDetailsCoordinator(rootViewController: rootViewController)
        showDetailsCoordinator.showId = show.id
        showDetailsCoordinator.showImage = show.image.image
        showDetailsCoordinator.start()
    }
}
