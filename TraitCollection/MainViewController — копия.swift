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

        let const1 = viewTopLeft.topAnchor.constraint(equalTo: view.topAnchor, constant: 24)
        let const2 = viewTopLeft.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
        let const3 = viewTopLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44)
//        let const4 = viewTopLeft.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -430)
//        let const4 = viewTopLeft.widthAnchor.constraint(equalTo: viewTopLeft.heightAnchor, constant: viewTopLeft.frame.height)

        let const5 = NSLayoutConstraint(
            item: viewTopLeft,
            attribute: .right,
            relatedBy: .equal,
            toItem: viewBottomRight,
            attribute: .left,
            multiplier: 1,
            constant: -10
        )


        let const6 = viewBottomRight.topAnchor.constraint(equalTo: view.topAnchor, constant: 24)
        let const7 = viewBottomRight.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
        let const8 = viewBottomRight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 44)

        let const9 = equalRation

//        const1.priority = .defaultHigh
//        const2.priority = .defaultHigh
//        const3.priority = .defaultLow
//        const4.priority = UILayoutPriority(1000)
//        const5.priority = .defaultLow
//        const6.priority = .defaultLow
//        const7.priority = .defaultLow
        const8.priority = .defaultHigh
        const9.priority = .defaultHigh

        regularConstraints.append(contentsOf: [const1, const2, const3, const5, const6, const7, const8, const9])
//            viewTopLeft.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
//            viewTopLeft.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
//            viewTopLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
//            viewTopLeft.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -430),
//
//            viewTopLeft.widthAnchor.constraint(equalTo: viewTopLeft.heightAnchor, constant: viewTopLeft.frame.height),
//
//            NSLayoutConstraint(
//                item: viewTopLeft,
//                attribute: .right,
//                relatedBy: .equal,
//                toItem: viewBottomRight,
//                attribute: .left,
//                multiplier: 1,
//                constant: -10
//            ),
//
//            viewBottomRight.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
//            viewBottomRight.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
//            viewBottomRight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 44),
//        ])


        let compact1 = viewTopLeft.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        let compact2 = viewTopLeft.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        let compact3 = viewTopLeft.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        let compact4 = verticalSpace
        let compact5 = equalRation

        let compact6 = viewBottomRight.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        let compact7 = viewBottomRight.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        let compact8 = viewBottomRight.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)

        compact1.priority = .defaultLow
        compact2.priority = .defaultLow
        compact3.priority = .defaultLow
        compact4.priority = .defaultLow
        compact5.priority = .defaultLow

        compact6.priority = .defaultLow
        compact7.priority = .defaultLow
        compact8.priority = .defaultLow

        compactConstraints.append(contentsOf: [compact1, compact2, compact3, compact4, compact5, compact6, compact7, compact8])

//            viewTopLeft.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            viewTopLeft.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            viewTopLeft.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            verticalSpace,
//            equalRation,
//
//            viewBottomRight.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            viewBottomRight.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            viewBottomRight.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
//        ])
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

