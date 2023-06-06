//
//  ViewController.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit
import Service

public class HomeViewController: UIViewController {

    var show: Show?

    let homeView: HomeView = {
        .init()
    }()

    public override func loadView() {
        super.loadView()
        view = homeView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        let repository = DefaultNetworkRepository()
        repository.request(endpoint: "api.tvmaze.com", path: "/shows", httpMethod: "GET", resultObject: Show.self) { result in
            switch result {
            case .success(let show):
                self.show = show
            default:
                break
            }
        }
    }
}
