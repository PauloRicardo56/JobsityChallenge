//
//  ViewController.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit

protocol HomeViewDisplay: AnyObject {
    func homeViewController(displayShows shows: [Show.ViewObject])
    func homeViewController(reloadShowOfId id: Int)
}

final class HomeViewController: UIViewController {

    var interactor: HomeInteractor?
    var coordinator: HomeCoordinator?

    lazy var homeView: HomeView = { view in
        view.delegate = self
        return view
    }(HomeView())

    override func loadView() {
        super.loadView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .black
        interactor?.fetchShows()
    }
}

extension HomeViewController: HomeViewDelegate {
    func homeView(didTapHome view: HomeView) {
        interactor?.fetchShows()
    }

    func homeView(didSearchWithText text: String) {
        interactor?.searchShows(with: text)
    }

    func homeView(didSelectShow show: Show.ViewObject) {
        coordinator?.homeCoordinator(showDetailsOfShow: show)
    }
}

extension HomeViewController: HomeViewDisplay {
    func homeViewController(displayShows shows: [Show.ViewObject]) {
        homeView.reloadCollection(with: shows)
    }

    func homeViewController(reloadShowOfId id: Int) {
        homeView.reloadItem(with: id)
    }
}
