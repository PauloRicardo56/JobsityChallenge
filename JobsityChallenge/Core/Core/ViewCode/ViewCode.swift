//
//  ViewCode.swift
//  Core
//
//  Created by Paulo Ricardo de Araujo Vieira on 06/06/23.
//

public protocol ViewCoding {
    func setupViewHierarchy()
    func setupViewContraints()
}

extension ViewCoding {
    public func setupView() {
        setupViewHierarchy()
        setupViewContraints()
    }
}
