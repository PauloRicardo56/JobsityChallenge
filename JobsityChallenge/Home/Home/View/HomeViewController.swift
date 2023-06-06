//
//  ViewController.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit
import Service

protocol HomeViewDisplay: AnyObject {
    func display(shows: [Show.ViewObject]?)
}

final class HomeViewController: UIViewController {

    var interactor: HomeInteractor?

    let homeView: HomeView = {
        .init()
    }()

    override func loadView() {
        super.loadView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.fetchShows()
    }
}

extension HomeViewController: HomeViewDisplay {

    func display(shows: [Show.ViewObject]?) {
        // Stop loading
        // Update collection view
    }
}
