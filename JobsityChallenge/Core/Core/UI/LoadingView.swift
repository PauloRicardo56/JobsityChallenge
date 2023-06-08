//
//  LoadingView.swift
//  Core
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

import UIKit

public final class LoadingView: UIView {

    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        view.color = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.alpha = 0.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupView()
        translatesAutoresizingMaskIntoConstraints = false
    }

    public override func didMoveToSuperview() {
        guard let superview = superview else { return }
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoadingView: ViewCoding {

    public func setupViewHierarchy() {
        addSubview(backView)
        addSubview(activityIndicator)
    }

    public func setupViewContraints() {
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),

            activityIndicator.widthAnchor.constraint(equalToConstant: 30),
            activityIndicator.heightAnchor.constraint(equalToConstant: 30),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
