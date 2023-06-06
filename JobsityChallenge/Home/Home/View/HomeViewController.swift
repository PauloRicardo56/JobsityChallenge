//
//  ViewController.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit
import Service

class HomeViewController: UIViewController {

    private let interactor: HomeInteractor?

    let homeView: HomeView = {
        .init()
    }()

    init(interactor: HomeInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.fetchShows()
    }
}
