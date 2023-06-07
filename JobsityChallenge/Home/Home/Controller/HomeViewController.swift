//
//  ViewController.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit
import Service

protocol HomeViewDisplay: AnyObject {
    func display(shows: [Show.ViewObject])
    func reloadShow(of id: Int)
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

        view.backgroundColor = .black
        interactor?.fetchShows()
    }
}

extension HomeViewController: HomeViewDisplay {
    func reloadShow(of id: Int) {
        homeView.reloadItem(with: id)
    }

    func display(shows: [Show.ViewObject]) {
        // Stop loading
        homeView.reloadCollection(with: shows)
    }
}
