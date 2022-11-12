//
//  ViewController.swift
//  TraitCollection
//
//  Created by Ildar Khabibullin on 11.11.2022.
//

import UIKit

class MainViewController: UIViewController {

    private var sharedConstraints: [NSLayoutConstraint] = []

    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []

    var stackView = UIStackView()
    var heightOfView = CGFloat()

    private lazy var viewTopLeft: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.8
        return view
    }()

    private lazy var viewBottomRight: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.8
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(stackView)

        stackView.addArrangedSubview(viewTopLeft)
        stackView.addArrangedSubview(viewBottomRight)

        stackView.backgroundColor = .systemGray

        stackView.distribution = .equalSpacing
        stackView.axis = .vertical

        setupConstraints()

        NSLayoutConstraint.activate(sharedConstraints)
        layoutTrait(traitCollection: UIScreen.main.traitCollection)

    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layoutTrait(traitCollection: traitCollection)
    }

    func setupConstraints() {

        sharedConstraints.append(contentsOf: [
            stackView.leadingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.topAnchor, constant: 16),

        ])

        regularConstraints.append(contentsOf: [
            stackView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 44),

        ])


        compactConstraints.append(contentsOf: [
            stackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 16),
        ])
    }

    func layoutTrait(traitCollection: UITraitCollection) {

        if (!sharedConstraints[0].isActive) {
            NSLayoutConstraint.activate(sharedConstraints)

        }

        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
//                stackView.distribution = .equalSpacing
//                stackView.axis = .horizontal

            }
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)


            }
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
}

