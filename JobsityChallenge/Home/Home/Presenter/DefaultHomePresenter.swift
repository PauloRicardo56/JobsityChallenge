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
        DispatchQueue.main.async {
            let showsVO = shows?.compactMap { show in
                
                Show.ViewObject(
                    name: show.name ?? "",
                    image: UIImageView(from: show.image?.medium ?? "") {
                    self.viewController?.reloadShow(of: shows?.firstIndex { $0.id == show.id } ?? 0)
                })
            }

            self.viewController?.display(shows: showsVO ?? [])
        }
    }
}
