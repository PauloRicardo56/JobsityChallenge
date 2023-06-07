//
//  ViewController.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit
import Service

protocol HomeViewDisplay: AnyObject {
    func homeViewController(displayShows shows: [Show.ViewObject])
    func homeViewController(reloadShowOfId id: Int)
}

final class HomeViewController: UIViewController {

    var interactor: HomeInteractor?

    lazy var homeView: HomeView = {
        $0.delegate = self
        return $0
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

    func homeView(didSearchWithText text: String) {
        interactor?.searchShows(with: text)
    }
}

extension HomeViewController: HomeViewDisplay {
    func homeViewController(displayShows shows: [Show.ViewObject]) {
        // Stop loading
        homeView.reloadCollection(with: shows)
    }

    func homeViewController(reloadShowOfId id: Int) {
        homeView.reloadItem(with: id)
    }
}
