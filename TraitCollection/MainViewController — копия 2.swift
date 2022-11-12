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

//        view.addSubview(stackView)
//        stackView.addArrangedSubview(<#T##view: UIView##UIView#>)
        view.addSubview(viewTopLeft)
        view.addSubview(viewBottomRight)

        setupConstraints()

        NSLayoutConstraint.activate(sharedConstraints)
        layoutTrait(traitCollection: UIScreen.main.traitCollection)

    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layoutTrait(traitCollection: traitCollection)
    }

    func setupConstraints() {

        let verticalSpace = NSLayoutConstraint(
            item: self.viewBottomRight,
            attribute: .top,
            relatedBy: .equal,
            toItem: viewTopLeft,
            attribute: .bottom,
            multiplier: 1,
            constant: 16
        )

        let equalRation = NSLayoutConstraint(
            item: self.viewTopLeft,
            attribute: .width,
            relatedBy: .equal,
            toItem: viewTopLeft,
            attribute: .height,
            multiplier: 1,
            constant: 0
        )

        sharedConstraints.append(contentsOf: [
            viewTopLeft.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            viewTopLeft.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            viewTopLeft.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            verticalSpace,
            equalRation,

            viewBottomRight.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            viewBottomRight.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            viewBottomRight.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        viewBottomRight.widthAnchor.constraint(equalToConstant: 100).priority = UILayoutPriority(100)
//        viewTopLeft.widthAnchor.constraint(equalToConstant: 100).priority = UILayoutPriority(750)

        regularConstraints.append(contentsOf: [
            viewTopLeft.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            viewTopLeft.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            viewTopLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
//            viewTopLeft.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -430),

            viewTopLeft.widthAnchor.constraint(equalTo: viewTopLeft.heightAnchor, constant: viewTopLeft.frame.height),

            NSLayoutConstraint(
                item: viewTopLeft,
                attribute: .right,
                relatedBy: .equal,
                toItem: viewBottomRight,
                attribute: .left,
                multiplier: 1,
                constant: -10
            ),

            viewBottomRight.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            viewBottomRight.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            viewBottomRight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 44),
            viewBottomRight.widthAnchor.constraint(equalToConstant: 100)
        ])



        compactConstraints.append(contentsOf: [
            viewTopLeft.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            viewTopLeft.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            viewTopLeft.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            verticalSpace,
            equalRation,

            viewBottomRight.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            viewBottomRight.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            viewBottomRight.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    func layoutTrait(traitCollection: UITraitCollection) {

        if (!sharedConstraints[0].isActive) {
            NSLayoutConstraint.activate(sharedConstraints)
        }

        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)

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

