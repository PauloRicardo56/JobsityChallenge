//
//  Coordinator.swift
//  Core
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit

public protocol Coordinator {
    var rootViewController: UINavigationController { get }

    func start(completion: (() -> Void)?)
}
