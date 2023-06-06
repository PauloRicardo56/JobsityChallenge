//
//  ViewController.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import UIKit

public class HomeViewController: UIViewController {

    let homeView: HomeView = {
        .init()
    }()

    public override func loadView() {
        super.loadView()
        view = homeView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
