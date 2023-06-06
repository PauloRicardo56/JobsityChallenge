//
//  DefaultHomePresenter.swift
//  Home
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

import Core
import UIKit

final class DefaultHomePresenter: HomePresenter {

    weak var viewController: HomeViewDisplay?

    func present(shows: [Show.Response]?) {

        let showsVO = shows?.compactMap { show in
            Show.ViewObject(image: UIImageView(from: show.image?.original ?? ""))
        }

        viewController?.display(shows: showsVO)
    }
}
