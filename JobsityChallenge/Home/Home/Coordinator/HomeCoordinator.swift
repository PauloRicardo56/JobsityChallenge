//
//  HomeCoordinator.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit
import Core

public final class HomeCoordinator: Coordinator {

    public let rootViewController: UINavigationController

    public init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    public func start(completion: (() -> Void)? = nil) {
        let controller = HomeViewController()
        let interactor = DefaultHomeInteractor()
        let presenter = DefaultHomePresenter()
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller

        rootViewController.pushViewController(controller, animated: true)
    }
}
